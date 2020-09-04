Rails.application.routes.draw do
  root to: 'categories#index'
  resources :users, except: :index
  resources :articles, except: :index
  resources :categories, only: %i[index show]
  resources :votes, only: %i[create destroy]
  resources :friendships, only: :create
  post '/friendship_confirm', to: 'friendships#confirm'
  post '/friendship_denied', to: 'friendships#denied'
  delete '/friendship_delete', to: 'friendships#delete_friendship'
  get '/form_loggin', to: 'loggins#form_loggin'
  post '/loggin', to: 'loggins#loggin'
  get '/logout', to: 'loggins#logout'
end
