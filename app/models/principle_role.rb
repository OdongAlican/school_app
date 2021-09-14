# frozen_string_literal: true

class PrincipleRole < ApplicationRecord
  belongs_to :principle
  belongs_to :role
end
