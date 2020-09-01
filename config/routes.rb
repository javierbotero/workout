Rails.application.routes.draw do
  root to: 'categories#index'
  resources :users, except: :index
  resources :articles, except: :index
  resources :categories, only: %i[index show]
  resources :votes, only: %i[create destroy]
  get '/form_loggin', to: 'loggins#form_loggin'
  post '/loggin', to: 'loggins#loggin'
  get '/logout', to: 'loggins#logout'
end
