# frozen_string_literal: true

class StaffsController < ApplicationController
  before_action :find_staff, only: %i[update show destroy]

  def index
    @staffs = Staff.all.limit(10).to_json({ include: 'role' })
    json_response(@staffs, :created)
  end

  def login
    @staff = Staff.find_by(email: params[:email])
    password = params.permit(:password)
    if @staff && @staff.password == password['password']
      token = encode_token({ staff_id: @staff.id }, 'staff')
      data = { staff: @staff, token: token }
      json_response(data, :ok)
    else
      json_response('Invalid staff name or password', :unauthorized)
    end
  end

  def create
    @staff = Staff.create(staff_params)
    @staff.password = random_password
    if @staff.save
      result = @staff.to_json({ include: 'role' })
      json_response(result, :created)
    else
      json_response('Can not be create', :unprocessable_entity)
    end
  end

  def show
    result = @staff.to_json({ include: 'role' })
    json_response(result, :created)
  end

  def update
    if @staff.update(staff_params)
      result = @staff.to_json(include: 'role')
      json_response(result, :unprocessable_entity)
    else
      json_response('Cannot update')
    end
  end

  private

  def find_staff
    @staff = Staff.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found', :unprocessable_entity)
  end

  def staff_params
    params.permit(:first_name, :last_name, :email, :password, :role_type, :role_id)
  end
end
