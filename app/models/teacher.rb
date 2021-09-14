# frozen_string_literal: true

class Teacher < ApplicationRecord
  has_many :teacher_roles, dependent: :destroy
  has_many :roles, through: :teacher_roles, dependent: :destroy
end
