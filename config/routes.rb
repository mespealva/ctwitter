Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers:{
    registrations: 'users/registrations'
  }
  post 'follow/:user_id', to:'users#follow', as: 'follow'
  resources :tweets, except:[:index, :edit, :update]
  get 'user/:user_id', to:'users#profile', as: 'profile'
  get 'retweet/:id', to: 'tweets#new_retweet', as: 'retweet' 
  post 'retweet/:id', to: 'tweets#retweet'
  post 'likes/:id', to: 'tweets#likes', as: 'likes'

  root to:'tweets#new'
end
