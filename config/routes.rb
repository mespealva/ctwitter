Rails.application.routes.draw do
  
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers:{
    registrations: 'users/registrations'
  }
  
  resources :tweets, except:[:index, :edit, :update]
  get 'api/news', to:'api#news'
  post 'api/new', to:'api#new'
  get 'api/:fecha1/:fecha2', to:'api#fecha'
  get 'user/:id', to:'users#profile', as: 'profile'
  get 'retweet/:id', to: 'tweets#new_retweet', as: 'retweet' 
  post 'follow/:user_id', to:'users#follow', as: 'follow'
  post 'unfollow/:user_id', to:'users#unfollow', as: 'unfollow'
  post 'retweet/:id', to: 'tweets#retweet'
  post 'likes/:id', to: 'tweets#likes', as: 'likes'

  root to:'tweets#new'
end
