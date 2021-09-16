# frozen_string_literal: true

class TeacherStream < ApplicationRecord
  belongs_to :teacher
  belongs_to :stream
end
