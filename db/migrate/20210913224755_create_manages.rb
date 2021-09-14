# frozen_string_literal: true

class CreateManages < ActiveRecord::Migration[6.0]
  def change
    create_table :manages do |t|
      t.references :role, null: false, foreign_key: true
      t.references :permission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
