# frozen_string_literal: true

class PrincipleStream < ApplicationRecord
  belongs_to :principle
  belongs_to :stream
end
