# frozen_string_literal: true

class CreateSemesters < ActiveRecord::Migration[6.0]
  def change
    create_table :semesters do |t|
      t.string :name

      t.timestamps
    end
  end
end
