# frozen_string_literal: true

class PermissionsController < ApplicationController
  before_action :find_permission, only: %i[show destroy]
  before_action :authorized

  def index
    @permissions = Permission.all
    json_response(@permissions, :created)
  rescue ActiveRecord::RecordNotFound
    json_response({ error: 'Permissions not found', status: 404 })
  end

  def create
    @permission = Permission.create(permission_params)
    if @permission.save
      json_response(@permission, :created)
    else
      error = 'Improper rights'
      json_response(error, :unprocessable_entity)
    end
  end

  def show
    json_response(@permission, :created)
  end

  def destroy
    if @permission.destroy
      data = { 'message' => 'pemission destroyed' }
      json_response(data, :no_content)
    else
      data = { 'message' => 'Something went wrong' }
      json_response(data, :no_content)
    end
  end

  private

  def find_permission
    @permission = Permission.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response({ error: 'Permission not found', status: 404 })
  end

  def permission_params
    params.permit(:name)
  end
end
