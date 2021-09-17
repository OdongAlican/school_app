# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'students/login', to: 'students#login'
  post 'teachers/login', to: 'teachers#login'
  post 'staffs/login', to: 'staffs#login'
  post 'principles/login', to: 'principles#login'
  post 'supers/login', to: 'supers#login'

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
