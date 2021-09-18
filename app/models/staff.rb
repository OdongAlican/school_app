# frozen_string_literal: true

class Staff < ApplicationRecord
  belongs_to :role, dependent: :destroy
  has_many :principle_staffs, dependent: :destroy
  has_many :principles, through: :principle_staffs, dependent: :destroy
end
