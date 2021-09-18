# frozen_string_literal: true

class Student < ApplicationRecord
  validate :validate_streams_per_semester
  has_many :student_roles, dependent: :destroy
  has_many :roles, through: :student_roles, dependent: :destroy
  has_many :student_streams, dependent: :destroy
  has_many :streams, through: :student_streams, dependent: :destroy
  has_many :principle_students, dependent: :destroy
  has_many :principles, through: :principle_students, dependent: :destroy

  def validate_streams_per_semester
    if streams.length > 6
      count = 0
      (0...streams.length).each do |i|
        count = 0
        value = streams[i].semester_id
        (0...streams.length).each do |j|
          next unless value == streams[j].semester_id

          count += 1
          errors.add(:streams, :invalid) if count > 6
        end
      end
    end
  end
end
