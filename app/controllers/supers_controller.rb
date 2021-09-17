# frozen_string_literal: true

class SupersController < ApplicationController
  before_action :find_super, only: %i[show]

  def index
    @supers = Super.all
    json_response(@supers, :created)
  end

  def login
    @super = Super.find_by(email: params[:email])
    password = params.permit(:password)
    if @super && @super.password == password['password']
      token = encode_token({ super_id: @super.id }, 'super')
      data = { super: @super, token: token }
      json_response(data, :ok)
    else
      json_response('Invalid super name or password', :unauthorized)
    end
  end

  def create
    @super = Super.create(super_params)
    if @super.save
      json_response(@super, :created)
    else
      json_response('Something went wrong')
    end
  end

  def update
    if @super.update(super_params)
      json_response(@super, :created)
    else
      json_response('Something went wrong')
    end
  end

  def show
    result = @super.to_json({ include: { roles: { include: 'permissions' } } })
    json_response(result)
  end

  private

  def find_super
    @super = Super.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record Not Found')
  end

  def super_params
    params.permit(:first_name, :last_name, :email, :password, role_ids: [])
  end
end
