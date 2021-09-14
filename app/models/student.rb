# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :student_roles, dependent: :destroy
  has_many :roles, through: :student_roles, dependent: :destroy
end
