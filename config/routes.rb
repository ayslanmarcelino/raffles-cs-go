# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admins do
    get 'users/index'
    get 'item_types/index'
    get 'skin_types/index'
    get 'skin_exteriors/index'
    get 'transaction_types/index'
    get 'skins/index'
    get 'dashboard/index'

    resources :users
    resources :item_types
    resources :skin_types
    resources :skin_exteriors
    resources :transaction_types
    resources :skins do
      collection do
        get 'search'
      end
    end
  end

  get 'dashboard/index'
  devise_for :users

  root to: 'dashboard#index'
end
