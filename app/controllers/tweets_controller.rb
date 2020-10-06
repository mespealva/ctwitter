class TweetsController < ApplicationController
  before_action :set_tweet, only: [ :show, :destroy, :likes, :new_retweet, :retweet]

 
  def show
    @like = Like.where("tweet_id = ?", params[:id])
    unless @tweet.rt.nil?
      @rt = Tweet.find(@tweet.rt)
    end
  end

  def new
    if(params[:search] && !params[:search].empty? )
      @tweets = Tweet.where("content LIKE ?", "%#{params[:search]}%").order(created_at: :desc).page(params[:page]).per(50) 
    else
      if user_signed_in?
        @new = Tweet.new
        @like = Like.new
        @tweets = Tweet.nuevos.tweets_for_me(current_user).page(params[:page]).per(50)
        #@rt = Tweet.new
      else
        @tweets = Tweet.all.nuevos.page(params[:page]).per(50)
      end
    end
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id 
    #@tweet.content = @tweet.add_hashtags
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
