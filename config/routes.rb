Rails.application.routes.draw do
  
  devise_for :users, controllers:{
    registrations: 'users/registrations'
  }
  post 'follow/:user_id', to:'users#follow', as: 'follow'
  get 'search/:search', to:'tweets#search', as: 'search'
  resources :tweets, except:[:index, :edit, :update]
  #get 'search', to: 'tweets#search'
  get 'retweet/:id', to: 'tweets#new_retweet', as: 'retweet' 
  post 'retweet/:id', to: 'tweets#retweet'
  post 'likes/:id', to: 'tweets#likes', as: 'likes'

  root to:'tweets#new'
end
