# frozen_string_literal: true

class StudentRole < ApplicationRecord
  belongs_to :student
  belongs_to :role
end
