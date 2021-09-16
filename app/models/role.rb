# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :staffs, dependent: :delete_all
  has_many :manages, dependent: :destroy
  has_many :permissions, through: :manages, dependent: :destroy
  has_many :student_roles, dependent: :destroy
  has_many :students, through: :student_roles, dependent: :destroy
  has_many :teacher_roles, dependent: :destroy
  has_many :teachers, through: :teacher_roles, dependent: :destroy
  has_many :principle_roles, dependent: :destroy
  has_many :principles, through: :principle_roles, dependent: :destroy
  has_many :super_roles, dependent: :destroy
  has_many :supers, through: :super_roles, dependent: :destroy
end
