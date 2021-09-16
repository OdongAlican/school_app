# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Destroy any permission if it exits
# Permission.destroy_all

# Destroy any role if it exits
roles_array = []
Role.all.each do |role|
  roles_array.push(role.id)
end

# Create super user
Super.create([
               {
                 first_name: 'Super',
                 password: 'super123',
                 last_name: 'Admin',
                 email: 'superuser@example.com',
                 role_ids: roles_array
               }
             ])
