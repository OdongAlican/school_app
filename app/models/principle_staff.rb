# frozen_string_literal: true

class PrincipleStaff < ApplicationRecord
  belongs_to :principle
  belongs_to :staff
end
