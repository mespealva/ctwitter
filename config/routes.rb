Rails.application.routes.draw do
  
  devise_for :users, controllers:{
    registrations: 'users/registrations'
  }
  resources :tweets, except:[:index, :edit, :update]
  get 'retweet/:id', to: 'tweets#new_retweet', as: 'retweet' 
  post 'retweet/:id', to: 'tweets#retweet'
 
  post 'likes/:id', to: 'tweets#likes', as: 'likes'
  root to:'tweets#new'
end
