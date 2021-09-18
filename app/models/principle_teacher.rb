# frozen_string_literal: true

class PrincipleTeacher < ApplicationRecord
  belongs_to :principle
  belongs_to :teacher
end
