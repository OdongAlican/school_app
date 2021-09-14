# frozen_string_literal: true

class TeacherRole < ApplicationRecord
  belongs_to :teacher
  belongs_to :role
end
