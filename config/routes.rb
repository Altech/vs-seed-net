VsSeed::Application.routes.draw do
  get  "/"      => 'top#index'
  get  "login"  => 'log#in'
  post "login"  => 'log#auth'
  get  "logout" => 'log#out'
  resources :videos, only: %i[show update]
  resources :events, only: %i[index show edit update], constraints: {id: /\d\d\d\d-\d\d-\d\d/ }
  resources :event_reports, only: %i[create update]
  resources :mechas, only: %i[index show]
  resources :comments, only: %i[create]
  resources :favorites, only: %i[index create]
  delete "favorites" => 'favorites#destroy'
  resources :players, only: %i[index show create new edit update]

  if Rails.env.production?
    match '*not_found' => 'application#render_404', via: [:get, :post]
  end
end
