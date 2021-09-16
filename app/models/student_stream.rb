# frozen_string_literal: true

class StudentStream < ApplicationRecord
  belongs_to :student
  belongs_to :stream
end
