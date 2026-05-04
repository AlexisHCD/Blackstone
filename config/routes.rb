Rails.application.routes.draw do
  root "home#index"

  resources :categories, only: [:index, :show]
  resources :tools, only: [:index, :show]

  namespace :admin do
    root to: "dashboard#index"
    resources :categories
    resources :tools
  end
end