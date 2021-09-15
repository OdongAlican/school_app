# frozen_string_literal: true

class RenameRoleToRoleType < ActiveRecord::Migration[6.0]
  def change
    rename_column :staffs, :role, :role_type
  end
end
