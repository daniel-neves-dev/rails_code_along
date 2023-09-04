Rails.application.routes.draw do
  root 'pages#index'
  resources :posts
  devise_for :users

end
