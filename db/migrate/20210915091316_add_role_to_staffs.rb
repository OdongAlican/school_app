# frozen_string_literal: true

class AddRoleToStaffs < ActiveRecord::Migration[6.0]
  def change
    add_column :staffs, :role, :string
  end
end
