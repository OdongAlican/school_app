# frozen_string_literal: true

class Staff < ApplicationRecord
  belongs_to :role, dependent: :destroy
end
