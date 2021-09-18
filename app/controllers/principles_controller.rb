# frozen_string_literal: true

class PrinciplesController < ApplicationController
  before_action :find_principle, only: %i[show destroy update]
  before_action :authorized, except: %i[login]
  before_action :user_roles_list, except: %i[login]

  def index
    if current_user.class.name == 'Principle' || current_user.class.name == 'Super'
      @principles = Principle.all.limit(10).to_json({ include: { roles: { include: 'permissions' } } })
      json_response(@principles, :created)
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def login
    @principle = Principle.find_by(email: params[:email])
    password = params.permit(:password)
    if @principle && @principle.password == password['password']
      token = encode_token({ principle_id: @principle.id })
      data = { principle: @principle, token: token }
      json_response(data, :ok)
    else
      json_response('Invalid principle name or password', :unauthorized)
    end
  end

  def create
    if current_user.class.name == 'Principle' || current_user.class.name == 'Super'
      @principle = Principle.create(principle_params)
      @principle.password = random_password
      if @principle.save
        result = @principle.to_json({ include: { roles: { include: 'permissions' } } })
        json_response(result, :created)
      else
        json_response('Cannot create', :unprocessable_entity)
      end
    else
      json_response('Invalid principle name or password', :unauthorized)
    end
  end

  def show
    if current_user.class.name == 'Principle' || current_user.class.name == 'Super'
      result = @principle.to_json({ include: { roles: { include: 'permissions' } } })
      json_response(result, :created)
    else
      json_response('Invalid principle name or password', :unauthorized)
    end
  end

  def update
    if current_user.class.name == 'Principle' || current_user.class.name == 'Super'
      if @principle.update(principle_params)
        result = @principle.to_json({ include: { roles: { include: 'permissions' } } })
        json_response(result, :created)
      else
        json_response('Update errors', :unprocessable_entity)
      end
    else
      json_response('Invalid principle name or password', :unauthorized)
    end
  end

  def destroy
    if current_user.class.name == 'Principle' || current_user.class.name == 'Super'
      if @principle.destroy
        data = { 'message' => 'principle destroyed' }
        json_response(data, :no_content)
      else
        data = { 'message' => 'Something went wrong' }
        json_response(data, :no_content)
      end
    else
      json_response('Invalid principle name or password', :unauthorized)
    end
  end

  private

  def user_roles_list
    determine_type(current_user)
  end

  def find_principle
    @principle = Principle.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found', :unprocessable_entity)
  end

  def principle_params
    params.permit(:first_name, :last_name, :email, :password, role_ids: [])
  end
end

# "email" : "justine@gmail.com",
# "password": "lNCvaUbm0A"
