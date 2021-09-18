# frozen_string_literal: true

class StaffsController < ApplicationController
  before_action :find_staff, only: %i[update show destroy]
  before_action :authorized, except: %i[login]
  before_action :user_roles_list, except: %i[login]

  def index
    if (@user_roles_list & %w[Staff Admin Contractor]).any?
      @staffs = Staff.all.limit(10).to_json({ include: 'role' })
      json_response(@staffs, :created)
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def login
    @staff = Staff.find_by(email: params[:email])
    password = params.permit(:password)
    if @staff && @staff.password == password['password']
      token = encode_token({ staff_id: @staff.id })
      data = { staff: @staff, token: token }
      json_response(data, :ok)
    else
      json_response('Invalid staff name or password', :unauthorized)
    end
  end

  def create
    if current_user.class.name == 'Principle' && @user_roles_list.include?('Admin')
      @staff = Staff.create(staff_params)
      @staff.password = random_password
      if @staff.save
        result = @staff.to_json({ include: 'role' })
        json_response(result, :created)
      else
        json_response('Can not be create', :unprocessable_entity)
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def show
    if (@user_roles_list & %w[Staff Admin Contractor]).any?
      result = @staff.to_json({ include: 'role' })
      json_response(result, :created)
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def update
    if (@user_roles_list & %w[Staff Admin Contractor]).any?
      if @staff.update(staff_params)
        result = @staff.to_json(include: 'role')
        json_response(result, :unprocessable_entity)
      else
        json_response('Cannot update')
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def destroy
    if current_user.class.name == 'Principle' && @user_roles_list.include?('Admin')
      if @staff.destroy
        data = { 'message' => 'staff destroyed' }
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

  def find_staff
    @staff = Staff.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found', :unprocessable_entity)
  end

  def staff_params
    params.permit(:first_name, :last_name, :email, :password, :role_type, :role_id)
  end
end
