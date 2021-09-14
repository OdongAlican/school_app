# frozen_string_literal: true

class CreatePrincipleRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :principle_roles do |t|
      t.references :principle, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
