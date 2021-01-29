# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :super_admins do
    get 'enterprises/index'

    resources :enterprises
  end

  namespace :owners do
    get 'enterprises/index'
    get 'users/index'

    resources :enterprises
    resources :users
  end

  namespace :admins do
    get 'transaction_types/index'
    get 'transactions/index'
    get 'steam_accounts/index'
    get 'skins/index'
    get 'dashboard/index'

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

  root to: 'market#index'
end
