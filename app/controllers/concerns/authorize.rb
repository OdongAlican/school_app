# frozen_string_literal: true

module Authorize
  def user_roles(user)
    roles_list = []
    user.roles.each do |role|
      roles_list.push(role['name'])
    end
    roles_list
  end

  def determine_type(current_user)
    if current_user.class.name == 'Teacher'
      teacher = Teacher.find_by(id: current_user['id'])
      @user_roles_list = user_roles(teacher)
    elsif current_user.class.name == 'Student'
      student = Student.find_by(id: current_user['id'])
      @user_roles_list = user_roles(student)
    elsif current_user.class.name == 'Principle'
      principle = Principle.find_by(id: current_user['id'])
      @user_roles_list = user_roles(principle)
    elsif current_user.class.name == 'Staff'
      result = Staff.find_by(id: current_user['id'])
      role = Role.find_by(id: result.role_id)
      @user_roles_list = [role.name]
    elsif current_user.class.name == 'Super'
      super_user = Super.find_by(id: current_user['id'])
      @user_roles_list = user_roles(super_user)
    end
  end
end
