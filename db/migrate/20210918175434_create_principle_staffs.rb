# frozen_string_literal: true

class CreatePrincipleStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :principle_staffs do |t|
      t.references :principle, null: false, foreign_key: true
      t.references :staff, null: false, foreign_key: true

      t.timestamps
    end
  end
end
