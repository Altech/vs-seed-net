VsSeed::Application.routes.draw do
  get  "/"      => 'top#index'
  get  "login"  => 'log#in'
  post "login"  => 'log#auth'
  get  "logout" => 'log#out'
  resources :videos, only: %i[show]
  resources :events, only: %i[index show], constraints: {id: /\d\d\d\d-\d\d-\d\d/ }
  resources :mechas, only: %i[index show]
  resources :comments, only: %i[create]
  resources :favorites, only: %i[index create]
  delete "favorites" => 'favorites#destroy'
  resources :players, only: %i[create new]

  if Rails.env.production?
    match '*not_found' => 'application#render_404', via: [:get, :post]
  end
end
