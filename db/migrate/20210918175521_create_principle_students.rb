# frozen_string_literal: true

class CreatePrincipleStudents < ActiveRecord::Migration[6.0]
  def change
    create_table :principle_students do |t|
      t.references :principle, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
  end
end
