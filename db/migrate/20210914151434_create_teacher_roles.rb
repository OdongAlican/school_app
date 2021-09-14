# frozen_string_literal: true

class CreateTeacherRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_roles do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
