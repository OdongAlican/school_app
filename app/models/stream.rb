# frozen_string_literal: true

class Stream < ApplicationRecord
  validates :students, length: { maximum: 59 }
  belongs_to :semester
  has_many :teacher_streams, dependent: :destroy
  has_many :teachers, through: :teacher_streams, dependent: :destroy
  has_many :student_streams, dependent: :destroy
  has_many :students, through: :student_streams, dependent: :destroy
end
