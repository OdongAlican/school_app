# frozen_string_literal: true

class StudentsController < ApplicationController
  before_action :find_student, only: %i[update show destroy]
  before_action :authorized, except: %i[login]

  def index
    @students = Student.all.limit(10).to_json({ include: { roles: { include: 'permissions' } } })
    json_response(@students, :created)
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
    @student = Student.create(student_params)
    @student.password = random_password
    if @student.save
      result = @student.to_json({ include: [:streams, { roles: { include: 'permissions' } }] })
      json_response(result, :created)
    else
      json_response('Error creating Student', :unprocessable_entity)
    end
  end

  def show
    result = @student.to_json({ include: [:streams, { roles: { include: 'permissions' } }] })
    json_response(result, :created)
  end

  def update
    if @student.update(student_params)
      result = @student.to_json({ include: [:streams, { roles: { include: 'permissions' } }] })
      json_response(result, :created)
    else
      json_response('Cannot update Student', :unprocessable_entity)
    end
  end

  def destroy
    if @student.destroy
      data = { 'message' => 'student destroyed' }
      json_response(data, :no_content)
    else
      data = { 'message' => 'Something went wrong' }
      json_response(data, :no_content)
    end
  end

  private

  def find_student
    @student = Student.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found', :unprocessable_entity)
  end

  def student_params
    params.permit(:first_name, :last_name, :email, :password, role_ids: [], stream_ids: [])
  end
end
