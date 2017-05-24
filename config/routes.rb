Rails.application.routes.draw do
  devise_for :users
  resources :performances, only: %i(index show new create)
  resources :places, only: %i(index show new create), shallow: true do
    resources :events, only: %i(index show new create)
  end
  root to: 'pages#home'
  mount Attachinary::Engine => "/attachinary"
end
