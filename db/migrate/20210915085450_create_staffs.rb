# frozen_string_literal: true

class CreateStaffs < ActiveRecord::Migration[6.0]
  def change
    create_table :staffs do |t|
      t.string :last_name
      t.string :first_name
      t.string :email
      t.string :password
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
