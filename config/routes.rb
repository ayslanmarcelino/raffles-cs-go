# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admins do
    get 'users/index'
    get 'transaction_types/index'
    get 'transactions/index'
    get 'steam_accounts/index'
    get 'skins/index'
    get 'dashboard/index'

    resources :users
    resources :transaction_types
    resources :transactions
    resources :steam_accounts
    resources :skins do
      collection do
        post 'search'
        post 'refresh_skins'
        delete 'destroy_multiple'
      end
    end
  end

  get 'dashboard/index'
  get 'market/index'
  devise_for :users

  root to: 'dashboard#index'
end
