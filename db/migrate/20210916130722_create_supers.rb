# frozen_string_literal: true

class CreateSupers < ActiveRecord::Migration[6.0]
  def change
    create_table :supers do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password

      t.timestamps
    end
  end
end
