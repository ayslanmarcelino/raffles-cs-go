# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admins do
    get 'users/index'
    get 'item_types/index'

    resources :users
    resources :item_types
  end

  get 'dashboard/index'
  devise_for :users

  root to: 'dashboard#index'
end
