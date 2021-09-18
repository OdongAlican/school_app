# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include Password
  include Authorize

  def encode_token(payload)
    JWT.encode(payload, 's3cr3t')
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, 's3cr3t', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_route = decoded_token[0].keys[0]
      if user_route == 'student_id'
        user_id = decoded_token[0]['student_id']
        @user = Student.find_by(id: user_id)
      elsif user_route == 'teacher_id'
        user_id = decoded_token[0]['teacher_id']
        @user = Teacher.find_by(id: user_id)
      elsif user_route = 'principle_id'
        user_id = decoded_token[0]['principle_id']
        @user = Principle.find_by(id: user_id)
      end
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
