# frozen_string_literal: true

class Principle < ApplicationRecord
  has_many :principle_roles, dependent: :destroy
  has_many :roles, through: :principle_roles, dependent: :destroy
end
