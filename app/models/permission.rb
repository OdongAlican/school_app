# frozen_string_literal: true

class Permission < ApplicationRecord
  has_many :manages, dependent: :destroy
  has_many :roles, through: :manages, dependent: :destroy
end
