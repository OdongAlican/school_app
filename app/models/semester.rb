# frozen_string_literal: true

class Semester < ApplicationRecord
  has_many :streams, dependent: :delete_all
end
