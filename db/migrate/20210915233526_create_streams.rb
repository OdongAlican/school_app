# frozen_string_literal: true

class CreateStreams < ActiveRecord::Migration[6.0]
  def change
    create_table :streams do |t|
      t.string :name
      t.references :semester, null: false, foreign_key: true

      t.timestamps
    end
  end
end
