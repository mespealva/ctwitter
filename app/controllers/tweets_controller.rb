class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :destroy]
 
  def show
    @like = Like.where("tweet_id = ?", params[:id])
    unless @tweet.rt.nil?
      @rt = Tweet.find(@twet.rt)
    end
  end

  def new
    @tweet = Tweet.new
    @tweets = Tweet.paginate(page: params[:page], per_page: 50).nuevos
    @like = Like.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id 
    if @tweet.save
      redirect_to @tweet, notice: 'Has Tweetiado' 
    else
      render :new 
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_url, notice: 'Tweet fue eliminado' 
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
    new_tweet= Tweet.new
     @tweet = Tweet.find(params[:id])
   end

   def retweet
     new_tweet = Tweet.create(content: params[:content], user: current_user, rt: @tweet.id)
     if new_tweet.save
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
end
