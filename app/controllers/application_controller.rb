# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Response
  include Password
  @user_current = ''
  def encode_token(payload, user)
    @user_current = user
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
    p '.........................'
    p '.........................'
    p @user_current
    p '.........................'
    p '.........................'
    if decoded_token
      user_id = decoded_token[0]['user_id']
      if @user_current == 'student'
        @user = Student.find_by(id: user_id)
      elsif @user_current == 'teacher'
        @user = Teacher.find_by(id: user_id)
      end
    end
  end

  def logged_in?
    current_user
    !!current_user
  end

  def authorized
    render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
