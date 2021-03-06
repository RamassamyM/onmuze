Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  resources :performances, only: %i(index show new create update) do
    resources :proposals, only: %i(create)
  end
  resources :places, only: %i(index show new create update), shallow: true do
    resources :events, only: %i(index show create update), shallow: true do
      resources :promotions, only: %i(create)
    end
  end
  resources :events, only: %i(create)
  resources :proposals, only: %i(update)
  root 'pages#startdirect'
  get 'home', to: 'pages#home'
  get 'choose', to: 'pages#choose'
  get 'dashboard', to: 'pages#dashboard'
  mount Attachinary::Engine => "/attachinary"
end
