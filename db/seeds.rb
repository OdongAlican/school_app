# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Destroy any permission if they exits
Permission.destroy_all

# Destroy any roles if they exits
Role.destroy_all

# Create a List of roles
Role.create([
              { name: 'Student' },
              { name: 'Staff' },
              { name: 'Admin' },
              { name: 'Contractor' }
            ])

# Create a List of permission
Permission.create([
                    { name: 'Add Classes' },
                    { name: 'Add Students' },
                    { name: 'Hire Staff' },
                    { name: 'View records' },
                    { name: 'Enroll in school' },
                    { name: 'Enroll in classes ' },
                    { name: 'View Data Points' },
                    { name: 'Assign teachers to classes' },
                    { name: 'Display total number of classes' },
                    { name: 'Display total number of students' },
                    { name: 'Display Students per classes' }
                  ])

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
