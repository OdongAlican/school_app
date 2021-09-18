# frozen_string_literal: true

module Authorize
  def user_roles(user)
    roles_list = []
    user.roles.each do |role|
      roles_list.push(role['name'])
    end
    roles_list
  end
end
