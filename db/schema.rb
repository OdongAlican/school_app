# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_210_915_233_602) do
  create_table 'manages', force: :cascade do |t|
    t.integer 'role_id', null: false
    t.integer 'permission_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['permission_id'], name: 'index_manages_on_permission_id'
    t.index ['role_id'], name: 'index_manages_on_role_id'
  end

  create_table 'permissions', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'principle_roles', force: :cascade do |t|
    t.integer 'principle_id', null: false
    t.integer 'role_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['principle_id'], name: 'index_principle_roles_on_principle_id'
    t.index ['role_id'], name: 'index_principle_roles_on_role_id'
  end

  create_table 'principles', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.string 'password'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'roles', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'semesters', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'staffs', force: :cascade do |t|
    t.string 'last_name'
    t.string 'first_name'
    t.string 'email'
    t.string 'password'
    t.integer 'role_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'role_type'
    t.index ['role_id'], name: 'index_staffs_on_role_id'
  end

  create_table 'streams', force: :cascade do |t|
    t.string 'name'
    t.integer 'semester_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['semester_id'], name: 'index_streams_on_semester_id'
  end

  create_table 'student_roles', force: :cascade do |t|
    t.integer 'student_id', null: false
    t.integer 'role_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['role_id'], name: 'index_student_roles_on_role_id'
    t.index ['student_id'], name: 'index_student_roles_on_student_id'
  end

  create_table 'student_streams', force: :cascade do |t|
    t.integer 'student_id', null: false
    t.integer 'stream_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['stream_id'], name: 'index_student_streams_on_stream_id'
    t.index ['student_id'], name: 'index_student_streams_on_student_id'
  end

  create_table 'students', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.string 'password'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  create_table 'teacher_roles', force: :cascade do |t|
    t.integer 'teacher_id', null: false
    t.integer 'role_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['role_id'], name: 'index_teacher_roles_on_role_id'
    t.index ['teacher_id'], name: 'index_teacher_roles_on_teacher_id'
  end

  create_table 'teacher_streams', force: :cascade do |t|
    t.integer 'teacher_id', null: false
    t.integer 'stream_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['stream_id'], name: 'index_teacher_streams_on_stream_id'
    t.index ['teacher_id'], name: 'index_teacher_streams_on_teacher_id'
  end

  create_table 'teachers', force: :cascade do |t|
    t.string 'first_name'
    t.string 'last_name'
    t.string 'email'
    t.string 'password'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
  end

  add_foreign_key 'manages', 'permissions'
  add_foreign_key 'manages', 'roles'
  add_foreign_key 'principle_roles', 'principles'
  add_foreign_key 'principle_roles', 'roles'
  add_foreign_key 'staffs', 'roles'
  add_foreign_key 'streams', 'semesters'
  add_foreign_key 'student_roles', 'roles'
  add_foreign_key 'student_roles', 'students'
  add_foreign_key 'student_streams', 'streams'
  add_foreign_key 'student_streams', 'students'
  add_foreign_key 'teacher_roles', 'roles'
  add_foreign_key 'teacher_roles', 'teachers'
  add_foreign_key 'teacher_streams', 'streams'
  add_foreign_key 'teacher_streams', 'teachers'
end
