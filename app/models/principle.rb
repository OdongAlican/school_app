# frozen_string_literal: true

class Principle < ApplicationRecord
  has_many :principle_roles, dependent: :destroy
  has_many :roles, through: :principle_roles, dependent: :destroy

  has_many :principle_semesters, dependent: :destroy
  has_many :semesters, through: :principle_semesters, dependent: :destroy

  has_many :principle_teachers, dependent: :destroy
  has_many :teachers, through: :principle_teachers, dependent: :destroy

  has_many :principle_students, dependent: :destroy
  has_many :students, through: :principle_students, dependent: :destroy

  has_many :principle_staffs, dependent: :destroy
  has_many :staffs, through: :principle_staffs, dependent: :destroy

  has_many :principle_streams, dependent: :destroy
  has_many :streams, through: :principle_streams, dependent: :destroy
end
