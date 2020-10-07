# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admins do
    get 'users/index'

    resources :users
  end

  get 'dashboard/index'
  devise_for :users

  root to: 'dashboard#index'
end
