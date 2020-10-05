class UsersController < ApplicationController
    def follow
      if current_user.is_following?(User.find(params[:user_id]))
        Friend.where(user: current_user, friend_id: params[:user_id]).first.destroy
      else 
        Friend.create(user: current_user, friend_id: params[:user_id])
      end 
      redirect_to root_path
    end

    def profile
      @tweets = Tweet.where(user_id: params[:user_id]).page(params[:page]).per(50)
    end
end