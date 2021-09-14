# frozen_string_literal: true

class CreateStudentRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :student_roles do |t|
      t.references :student, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
