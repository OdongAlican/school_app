# frozen_string_literal: true

class RolesController < ApplicationController
  before_action :find_role, only: %i[show destroy update]

  def index
    @roles = Role.all.to_json({ include: 'permissions' })
    json_response(@roles, :created)
  rescue ActiveRecord::RecordNotFound
    json_response({ error: 'Roles not found', status: 404 })
  end

  def create
    @role = Role.create(role_params)
    if @role.save
      result = @role.to_json({ include: 'permissions' })
      json_response(result, :created)
    else
      error = 'Improper rights'
      json_response(error, :unprocessable_entity)
    end
  end

  def show
    result = @role.to_json({ include: 'permissions' })
    json_response(result, :created)
  end

  def destroy
    if @role.destroy
      data = { 'message' => 'post destroyed' }
      json_response(data, :no_content)
    else
      data = { 'message' => 'Something went wrong' }
      json_response(data, :unprocessable_entity)
    end
  end

  def update
    if @role.update(role_params)
      result = @role.to_json({ include: 'permissions' })
      json_response(result, :created)
    else
      json_response('Could not Update', :unprocessable_entity)
    end
  end

  private

  def find_role
    @role = Role.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response({ error: 'Role not found', status: 404 })
  end

  def role_params
    params.permit(:name, permission_ids: [])
  end
end
