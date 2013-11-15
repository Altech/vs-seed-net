VsSeed::Application.routes.draw do
  get "/" => 'top#index'
  get  "login"  => 'log#in'
  post "login"  => 'log#auth'
  get  "logout" => 'log#out'
  resources :videos, only: %i[show]
  match     'events/:date' => 'events#show', via: 'get', date: /\d\d-\d\d-\d\d/
  resources :events, only: %i[index show]
  resources :mechas, only: %i[index show]
  resources :comments, only: %i[create]
  resources :players, only: %i[create new]
end
