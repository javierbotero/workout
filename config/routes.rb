Rails.application.routes.draw do
  root to: 'categories#index'
  resources :users
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
  post '/photos/destroy', to: 'photos#destroy'
  post '/user/avatar/destroy', to: 'photos#avatar_destroy'
  patch '/user/avatar/update', to: 'photos#update_avatar'
  delete '/article/main/delete', to: 'photos#destroy_main'
  patch '/article/main/update', to: 'photos#update_main'
  patch '/article/photos/update', to: 'photos#photos_update'
end
