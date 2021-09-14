# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :manages, dependent: :destroy
  has_many :permissions, through: :manages, dependent: :destroy
  has_many :student_roles, dependent: :destroy
  has_many :students, through: :student_roles, dependent: :destroy
  has_many :teacher_roles, dependent: :destroy
  has_many :teachers, through: :teacher_roles, dependent: :destroy
end
