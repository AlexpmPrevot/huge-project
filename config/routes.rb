Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :hugs do
    resources :reviews, only: %i[new create]
  end
  resources :users, only: %i[show index]
end
