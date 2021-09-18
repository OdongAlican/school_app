# frozen_string_literal: true

class TeachersController < ApplicationController
  before_action :find_teacher, only: %i[update show destroy]
  before_action :authorized, except: %i[login]
  before_action :user_roles_list, except: %i[login]

  def index
    if (@user_roles_list & %w[Staff Admin]).any?
      @teachers = Teacher.all.limit(10).to_json({ include: { roles: { include: 'permissions' } } })
      json_response(@teachers, :created)
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def login
    @teacher = Teacher.find_by(email: params[:email])
    password = params.permit(:password)
    if @teacher && @teacher.password == password['password']
      token = encode_token({ teacher_id: @teacher.id })
      result = @teacher.to_json({ include: { roles: { include: 'permissions' } } })
      data = { teacher: result, token: token }
      json_response(data, :ok)
    else
      json_response('Invalid teacher name or password', :unauthorized)
    end
  end

  def create
    if @user_roles_list.include? 'Admin' && current_user.class.name == 'Principle'
      @teacher = Teacher.create(teacher_params)
      @teacher.password = random_password
      if @teacher.save
        result = @teacher.to_json({ include: { roles: { include: 'permissions' } } })
        json_response(result, :created)
      else
        json_response('Error creating teacher', :unprocessable_entity)
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def show
    result = @teacher.to_json({ include: ['streams', { roles: { include: 'permissions' } }] })
    json_response(result, :created)
  end

  def update
    if @teacher.update(teacher_params)
      result = @teacher.to_json({ include: ['streams', { roles: { include: 'permissions' } }] })
      json_response(result, :created)
    else
      json_response('Update errors', :unprocessable_entity)
    end
  end

  def destroy
    if @teacher.destroy
      data = { 'message' => 'student destroyed' }
      json_response(data, :no_content)
    else
      data = { 'message' => 'Something went wrong' }
      json_response(data, :no_content)
    end
  end

  private

  def user_roles_list
    if current_user.class.name == 'Teacher'
      teacher = Teacher.find_by(id: current_user['id'])
      @user_roles_list = user_roles(teacher)
    elsif current_user.class.name == 'Student'
      student = Student.find_by(id: current_user['id'])
      @user_roles_list = user_roles(student)
    elsif current_user.class.name == 'Principle'
      principle = Principle.find_by(id: current_user['id'])
      @user_roles_list = user_roles(principle)
    end
  end

  def find_teacher
    @teacher = Teacher.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found', :unprocessable_entity)
  end

  def teacher_params
    params.permit(:first_name, :last_name, :email, :password, role_ids: [], stream_ids: [])
  end
end
