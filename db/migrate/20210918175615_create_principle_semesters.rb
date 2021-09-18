# frozen_string_literal: true

class CreatePrincipleSemesters < ActiveRecord::Migration[6.0]
  def change
    create_table :principle_semesters do |t|
      t.references :principle, null: false, foreign_key: true
      t.references :semester, null: false, foreign_key: true

      t.timestamps
    end
  end
end
