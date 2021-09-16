# frozen_string_literal: true

class SemestersController < ApplicationController
  before_action :find_semester, only: %i[show update destroy]

  def index
    @semesters = Semester.all.limit(10)
    json_response(@semesters, :created)
  end

  def create
    @semester = Semester.create(semester_params)
    if @semester.save
      json_response(@semester, :created)
    else
      json_response('Creation Error', :unprocessable_entity)
    end
  end

  def show
    result = @semester.to_json(include: 'streams')
    json_response(result, :created)
  end

  def update
    if @semester.update(semester_params)
      json_response(@semester, :created)
    else
      json_response('Failed to update', :unprocessable_entity)
    end
  end

  def destroy
    if @semester.destroy
      json_response('semester Destroyed', :no_content)
    else
      json_response('Failed to destroy', :unprocessable_entity)
    end
  end

  private

  def find_semester
    @semester = Semester.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found')
  end

  def semester_params
    params.permit(:name)
  end
end
