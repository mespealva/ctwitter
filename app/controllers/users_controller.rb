class UsersController < ApplicationController
  def follow
    Friend.create(user: current_user, friend_id: params[:user_id])
    redirect_to root_path
  end

  def unfollow
    Friend.where(user: current_user, friend_id: params[:user_id]).first.destroy
    redirect_to root_path
  end

  def profile
    @tweets = Tweet.where(user_id: params[:id]).order("created_at DESC")
    @friend = Friend.amigos(current_user)
    @friends = @friend.reject {|f| !User.all.ids.include?(f.friend_id)}
    @amiges = @friends.map {|f| f= User.find(f.friend_id)}
    @rt = Tweet.new
    @user = User.find(params[:id])
    
  end
end