# frozen_string_literal: true

class PrincipleStudent < ApplicationRecord
  belongs_to :principle
  belongs_to :student
end
