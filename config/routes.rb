Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root "home#index"

  # Sitemap
  get "sitemap.xml", to: "sitemaps#index", defaults: { format: "xml" }

  resources :categories, only: [:index, :show]
  resources :tools, only: [:index, :show]
  resources :courses, only: [:index, :show]

  patch "video_progress", to: "video_progresses#upsert"

  # Favoritos
  resources :favorite_tools, only: [:create, :destroy]
  resources :favorite_courses, only: [:create, :destroy]
  get "mis-favoritos", to: "favorites#index", as: :favorites

  # Contacto
  resources :contact_messages, only: [:create]

  namespace :admin do
    root to: "dashboard#index"
    resources :categories
    resources :users, only: [:index] do
      member do
        patch :toggle_admin
      end
    end
    resources :tools
    resources :courses do
      resources :course_episodes, path: "episodes"
    end
    resources :contact_messages, only: [:index, :show, :destroy] do
      member do
        patch :mark_read
      end
    end
  end
end