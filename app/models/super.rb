# frozen_string_literal: true

class Super < ApplicationRecord
  has_many :super_roles, dependent: :destroy
  has_many :roles, through: :super_roles, dependent: :destroy

  def self.users
    sql = " SELECT * INTO users
            FROM ( SELECT password, email FROM students UNION ALL
                  SELECT password, email FROM teachers UNION ALL
                  SELECT password, email FROM staffs UNION ALL
                  SELECT password, email FROM streams )"
    ActiveRecord::Base.connection.execute(sql)
  end
end
