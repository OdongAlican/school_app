# frozen_string_literal: true

class CreatePrincipleTeachers < ActiveRecord::Migration[6.0]
  def change
    create_table :principle_teachers do |t|
      t.references :principle, null: false, foreign_key: true
      t.references :teacher, null: false, foreign_key: true

      t.timestamps
    end
  end
end
