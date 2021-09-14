# frozen_string_literal: true

class Manage < ApplicationRecord
  belongs_to :role
  belongs_to :permission
end
