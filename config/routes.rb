Rails.application.routes.draw do
  root to: "home#show"

  resources :users, except: [:index]
  resources :playlists, only: [:new, :create]

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'logout', to: 'sessions#destroy'
end
