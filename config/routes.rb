Rails.application.routes.draw do
  root to: "home#show"

  resources :users, except: [:index]

  resources :playlists, only: [:index, :new, :create]

  post '/playlists/:id/spotify', to: 'playlists/spotify#create', as: 'spotify_playlist'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'logout', to: 'sessions#destroy'
end
