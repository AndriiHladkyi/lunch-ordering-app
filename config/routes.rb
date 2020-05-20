Rails.application.routes.draw do
  root to: 'dashboard#index'
  get 'users/index'
  
  devise_for :users

  resources :orders
  resources :categories
  resources :items

  get 'dashboard/index'
  get 'dashboard/by_day/:date', to: 'dashboard#by_day', as: 'dashboard_by_day'
  get 'orders/by_day/:date', to: 'orders#by_day', as: 'orders_by_day'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :items, only: [:index]
      resources :orders, only: [:index, :show, :create]
      post 'authenticate', to: 'authentication#authenticate', as: 'authenticate'
    end
  end
end
