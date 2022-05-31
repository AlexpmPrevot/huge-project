Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :hugs do
    resources :reviews, only: %i[new create]
  end
  resources :users, only: %i[show index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
