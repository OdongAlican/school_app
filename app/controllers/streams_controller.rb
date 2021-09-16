# frozen_string_literal: true

class StreamsController < ApplicationController
  before_action :find_stream, only: %i[show update destroy]

  def index
    @streams = Stream.all.limit(10)
    json_response(@streams, :created)
  end

  def create
    @stream = Stream.create(stream_params)
    if @stream.save
      json_response(@stream, :created)
    else
      json_response('Error in creating', :unprocessable_entity)
    end
  end

  def show
    json_response(@stream, :created)
  end

  def update
    if @stream.update(stream_params)
      json_response(@stream, :created)
    else
      json_response('Failed to update', :unprocessable_entity)
    end
  end

  def destroy
    if @stream.destroy
      json_response('stream Destroyed', :no_content)
    else
      json_response('Failed to destroy', :unprocessable_entity)
    end
  end

  private

  def find_stream
    @stream = Stream.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found', :unprocessable_entity)
  end

  def stream_params
    params.permit(:name, :semester_id)
  end
end
