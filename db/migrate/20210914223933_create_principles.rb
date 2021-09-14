# frozen_string_literal: true

class CreatePrinciples < ActiveRecord::Migration[6.0]
  def change
    create_table :principles do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
