Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/forecast', to: 'forecasts#show'
      get '/backgrounds', to: 'backgrounds#show'
      resources :users, only: [:create]
      post '/sessions', to: 'sessions#create'
      resources :favorites, only: [:create, :index]
      delete '/favorites', to: 'favorites#delete'
    end
  end
end
