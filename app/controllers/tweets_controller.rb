class TweetsController < ApplicationController
  before_action :set_tweet, only: [ :show, :destroy, :likes, :new_retweet, :retweet]
  before_action :set_var, only:[:new, :new_retweet]

  def show
    @like = Like.where("tweet_id = ?", params[:id])
    unless Tweet.all.ids.include?(@tweet.rt)
      @tweet.rt = nil
    end
    unless @tweet.rt.nil?
      @rt = Tweet.find(@tweet.rt)
    end
    
    @friend = Friend.amigos(current_user)
    @friends = @friend.reject {|f| !User.all.ids.include?(f.friend_id)}
    @amiges = @friends.map {|f| f= User.find(f.friend_id)}
  end

  def new
    if(params[:search])
      @tweets = Tweet.where("content LIKE ?", "%#{params[:search]}%").order(created_at: :desc).page(params[:page]).per(50) 
      
    elsif user_signed_in?
      @new = Tweet.new
      @tweets = Tweet.nuevos.tweets_for_me(current_user).page(params[:page]).per(50)
    end
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id 
    if @tweet.save
      redirect_to root_path, notice: 'Has Tweetiado' 
    else
      redirect_to root_path, notice: 'ERROR!'
    end
  end

  def destroy
    @tweet.destroy
    redirect_to root_path, notice: 'Tweet fue eliminado' 
  end

  def likes
    if @tweet.is_liked?(current_user)
      @tweet.remove_like(current_user)
    else
      @tweet.add_like(current_user)
    end 
    redirect_to root_path
  end

   def new_retweet
    unless Tweet.all.ids.include?(@tweet.rt)
      @tweet.rt = nil
    end
    @new_ = Tweet.new
    @tweet = Tweet.find(params[:id])
    @friend = Friend.amigos(current_user)
    @friends = @friend.reject {|f| !User.all.ids.include?(f.friend_id)}
    @amiges = @friends.map {|f| f = User.find(f.friend_id)}
   end

   def retweet
     @new_ = Tweet.create(content: params[:content], user: current_user, rt: @tweet.id)
     if @new_.save
      redirect_to root_path, notice: 'se retwitio' 
    else
      redirect_to root_path, notice: 'ERROR!' 
    end
   end 

   
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content)
    end
    
    def set_var
      @rt = Tweet.new
      @like = Like.new
      @friend = Friend.amigos(current_user)
      @friends = @friend.reject {|f| !User.all.ids.include?(f.friend_id)}
      @amiges = @friends.map {|f| f= User.find(f.friend_id)}
   end
end
