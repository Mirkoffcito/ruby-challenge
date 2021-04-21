Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  namespace :api do
      namespace :v1 do
        scope '/auth' do
          post '/signin', to: 'user_token#create' # Para logearse
          post '/signup', to: 'users#create' # para crear un nuevo usuario
        end
          resources :studios do #api/v1/studios SHOWS ALL STUDIOS IMAGE AND NAME
              resources :movies
              resources :seriees
              resources :characters
          end
      end
  end
end