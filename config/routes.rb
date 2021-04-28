Rails.application.routes.draw do
  resources :genres
  post 'user_token' => 'user_token#create'
  namespace :api do
      namespace :v1 do
          scope '/auth' do
            post '/signin', to: 'user_token#create' # Para logearse
            post '/signup', to: 'users#create' # para crear un nuevo usuario
          end
          resources :users, only: [:index, :show, :destroy]
          resources :studios do #api/v1/studios SHOWS ALL STUDIOS IMAGE AND NAME
              resources :movies
              resources :seriees
              resources :characters
          end
          resources :genres, only: [:index, :show, :create, :destroy]
      end
  end
end