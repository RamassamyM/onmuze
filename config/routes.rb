Rails.application.routes.draw do
  devise_for :users
  resources :performances, only: %i(index show new create) do
    resources :proposals, only: %i(create)
  end
  resources :places, only: %i(index show new create), shallow: true do
    resources :events, only: %i(index show create)
  end
  resources :events, only: %i(create)
  resources :proposals, only: %i(update)
  root 'pages#startdirect'
  get 'home', to: 'pages#home'
  get 'choose', to: 'pages#choose'
  get 'dashboard', to: 'pages#dashboard'
  mount Attachinary::Engine => "/attachinary"
end
