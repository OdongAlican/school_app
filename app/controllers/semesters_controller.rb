# frozen_string_literal: true

class SemestersController < ApplicationController
  before_action :find_semester, only: %i[show update destroy]
  before_action :authorized, except: %i[login]
  before_action :user_roles_list, except: %i[login]

  def index
    if (@user_roles_list & %w[Staff Admin]).any?
      @semesters = Semester.all.limit(10)
      json_response(@semesters, :created)
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def create
    if current_user.class.name == 'Principle' && @user_roles_list.include?('Admin')
      @semester = Semester.create(semester_params)
      @semester.principle_ids.push(current_user.id)
      if @semester.save
        json_response(@semester, :created)
      else
        json_response('Creation Error', :unprocessable_entity)
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def show
    if (@user_roles_list & %w[Staff Admin]).any?
      result = @semester.to_json(include: 'streams')
      json_response(result, :created)
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def update
    if current_user.class.name == 'Principle' && @user_roles_list.include?('Admin')
      if @semester.update(semester_params)
        json_response(@semester, :created)
      else
        json_response('Failed to update', :unprocessable_entity)
      end
    else
      json_response('Not authorized', :unauthorized)
    end
  end

  def destroy
    if current_user.class.name == 'Principle' && @user_roles_list.include?('Admin')
      if @semester.destroy
        json_response('semester Destroyed', :no_content)
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

  def find_semester
    @semester = Semester.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    json_response('Record not found')
  end

  def semester_params
    params.permit(:name, principle_ids: [])
  end
end
