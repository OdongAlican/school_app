# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :find_student, only: %i[update show destroy]
  before_action :authorized, except: %i[login]
  before_action :user_roles_list, except: %i[login]

  def index
    if (@user_roles_list & %w[Staff Admin]).any?
      @students = Student.all.limit(10).to_json({ include: { roles: { include: 'permissions' } } })
      json_response(@students, :created)
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def login
    @student = Student.find_by(email: params[:email])
    password = params.permit(:password)
    if @student && @student.password == password['password']
      token = encode_token({ student_id: @student.id })
      data = { student: @student, token: token }
      json_response(data, :ok)
    else
      json_response('Invalid student name or password', :unauthorized)
    end
  end

  def create
    if current_user.class.name == 'Principle' && @user_roles_list.include?('Admin')
      @student = Student.create(student_params)
      @student.principle_ids = [current_user.id]
      @student.stream_ids = []
      @student.password = random_password
      if @student.save
        result = @student.to_json({ include: [:streams, { roles: { include: 'permissions' } }] })
        json_response(result, :created)
      else
        json_response('Error creating Student', :unprocessable_entity)
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def show
    if (@user_roles_list & %w[Staff Admin Student]).any?
      result = @student.to_json({ include: [:streams, { roles: { include: 'permissions' } }] })
      json_response(result, :created)
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def update
    if (@user_roles_list & %w[Admin Student]).any?
      if @student.update(student_params)
        result = @student.to_json({ include: [:streams, { roles: { include: 'permissions' } }] })
        json_response(result, :created)
      else
        json_response('Cannot update Student', :unprocessable_entity)
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def destroy
    if current_user.class.name == 'Principle' && @user_roles_list.include?('Admin')
      if @student.destroy
        data = { 'message' => 'student destroyed' }
        json_response(data, :no_content)
      else
        data = { 'message' => 'Something went wrong' }
        json_response(data, :no_content)
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  private

  def user_roles_list
    determine_type(current_user)
  end

  def find_student
    @student = Student.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found', :unprocessable_entity)
  end

  def student_params
    params.permit(:first_name, :last_name, :email, :password, role_ids: [], stream_ids: [], principle_ids: [])
  end
end

