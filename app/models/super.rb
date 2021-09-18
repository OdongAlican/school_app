# frozen_string_literal: true

class Super < ApplicationRecord
  has_many :super_roles, dependent: :destroy
  has_many :roles, through: :super_roles, dependent: :destroy
end
