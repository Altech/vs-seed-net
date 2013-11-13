VsSeed::Application.routes.draw do
  get "/" => 'top#index'
  resources :videos, only: %i[show]
  resources :events, only: %i[index show]
  resources :mechas, only: %i[index show]
  resources :comments, only: %i[create]
  resources :players, only: %i[create]
end
