# frozen_string_literal: true

class CreatePrincipleStreams < ActiveRecord::Migration[6.0]
  def change
    create_table :principle_streams do |t|
      t.references :principle, null: false, foreign_key: true
      t.references :stream, null: false, foreign_key: true

      t.timestamps
    end
  end
end
