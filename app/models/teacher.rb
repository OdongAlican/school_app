# frozen_string_literal: true

class Teacher < ApplicationRecord
  validate :validate_streams_per_semester
  has_many :teacher_roles, dependent: :destroy
  has_many :roles, through: :teacher_roles, dependent: :destroy
  has_many :teacher_streams, dependent: :destroy
  has_many :streams, through: :teacher_streams, dependent: :destroy
  has_many :principle_teachers, dependent: :destroy
  has_many :principles, through: :principle_teachers, dependent: :destroy

  def validate_streams_per_semester
    if streams.length > 3
      count = 0
      (0...streams.length).each do |i|
        count = 0
        value = streams[i].semester_id
        (0...streams.length).each do |j|
          next unless value == streams[j].semester_id

          count += 1
          errors.add(:streams, :invalid) if count > 3
        end
      end
    end
  end
end
