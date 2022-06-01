Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'user/sessions' }
  root to: 'pages#home'
  resources :hugs, :users do
    resources :reviews, only: %i[new create]
  end
  resources :users, only: %i[show index] do
    member do
      patch 'set_geoloc'
    end
  end
end
