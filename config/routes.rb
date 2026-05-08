Rails.application.routes.draw do
  devise_for :users
  root "home#index"

  resources :categories, only: [:index, :show]
  resources :tools, only: [:index, :show]

  namespace :admin do
    root to: "dashboard#index"
    resources :categories
    resources :tools
  end
end