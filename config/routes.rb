Rails.application.routes.draw do
  devise_for :users
  resources :performances, only: %i(index show)
  resources :places, only: %i(index show), shallow: true do
    resources :events, only: %i(index show new crete)
  end
  resources :places, only: %i(new create)
  root to: 'pages#home'
end
