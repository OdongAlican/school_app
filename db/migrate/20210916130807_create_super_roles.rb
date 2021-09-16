# frozen_string_literal: true

class CreateSuperRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :super_roles do |t|
      t.references :super, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
