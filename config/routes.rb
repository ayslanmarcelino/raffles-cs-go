# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admins do
    get 'users/index'
    get 'transaction_types/index'
    get 'skins/index'
    get 'dashboard/index'

    resources :users
    resources :transaction_types
    resources :skins do
      collection do
        get 'search'
        get 'refresh_skins'
      end
    end
  end

  get 'dashboard/index'
  devise_for :users

  root to: 'dashboard#index'
end
