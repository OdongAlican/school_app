# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :manages, dependent: :destroy
  has_many :permissions, through: :manages, dependent: :destroy
end
