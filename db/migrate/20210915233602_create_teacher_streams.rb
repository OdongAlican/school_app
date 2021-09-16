# frozen_string_literal: true

class CreateTeacherStreams < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_streams do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :stream, null: false, foreign_key: true

      t.timestamps
    end
  end
end
