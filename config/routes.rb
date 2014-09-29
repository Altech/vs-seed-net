VsSeed::Application.routes.draw do
  get  "/"      => 'top#index'
  resources :videos, only: %i[show update]
  resources :events, only: %i[index show edit update], constraints: {id: /\d\d\d\d-\d\d-\d\d/ }
  resources :mechas, only: %i[index show]
  resources :players, only: %i[index show]

  if Rails.env.production?
    match '*not_found' => 'application#render_404', via: [:get, :post]
  end
end
