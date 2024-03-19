Rails.application.routes.draw do
  namespace :admin do
      resources :admin_users
      resources :posts
      resources :users

      root to: "admin_users#index"
    end
  root 'pages#index'
  resources :posts
  devise_for :users

end
