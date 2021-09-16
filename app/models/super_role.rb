# frozen_string_literal: true

class SuperRole < ApplicationRecord
  belongs_to :super
  belongs_to :role
end
