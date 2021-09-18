# frozen_string_literal: true

class Semester < ApplicationRecord
  has_many :streams, dependent: :delete_all
  has_many :principle_semesters, dependent: :destroy
  has_many :principles, through: :principle_semesters, dependent: :destroy
end
