# frozen_string_literal: true

class StreamsController < ApplicationController
  before_action :find_stream, only: %i[show update destroy]
  before_action :authorized, except: %i[login]
  before_action :user_roles_list, except: %i[login]

  def index
    if (@user_roles_list & %w[Staff Admin]).any?
      @streams = Stream.all.limit(10)
      json_response(@streams, :created)
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def create
    if current_user.class.name == 'Principle' && @user_roles_list.include?('Admin')
      @stream = Stream.create(stream_params)
      @stream.principle_ids = [current_user.id]
      if @stream.save
        json_response(@stream, :created)
      else
        json_response('Error in creating', :unprocessable_entity)
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def show
    if (@user_roles_list & %w[Staff Admin]).any?
      json_response(@stream, :created)
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def update
    if current_user.class.name == 'Principle' && @user_roles_list.include?('Admin')
      if @stream.update(stream_params)
        json_response(@stream, :created)
      else
        json_response('Failed to update', :unprocessable_entity)
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def destroy
    if current_user.class.name == 'Principle' && @user_roles_list.include?('Admin')
      if @stream.destroy
        json_response('stream Destroyed', :no_content)
      else
        json_response('Failed to destroy', :unprocessable_entity)
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  private

  def user_roles_list
    determine_type(current_user)
  end

  def find_stream
    @stream = Stream.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found', :unprocessable_entity)
  end

  def stream_params
    params.permit(:name, :semester_id, principle_ids: [])
  end
end
