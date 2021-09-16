# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :permissions
  resources :roles
  resources :students
  resources :teachers
  resources :principles
  resources :staffs
  resources :streams
  resources :semesters
  resources :supers, except: %i[create]
end
