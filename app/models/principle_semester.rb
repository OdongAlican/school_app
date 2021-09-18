# frozen_string_literal: true

class PrincipleSemester < ApplicationRecord
  belongs_to :principle
  belongs_to :semester
end
