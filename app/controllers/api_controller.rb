class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :check_auth, only:[:new]

  def check_auth
    authenticate_or_request_with_http_basic do |email, password|
      resource = User.find_by(email: email)
      if resource.valid_password?(password)
        sign_in :user, resource
      end
    end
  end
  
  def news
    @fifty = Tweet.fifty
    if @fifty.nil?
      render json: { message: "ningun tweet encontrado"}
    else
      tweets =  []
      @fifty.each do |t|
        hash={}
        hash={id: t.id,
          content: t.content,
          user_id: t.user_id,
          like_count: t.likes.count,
          retweets_count: t.count_rt, 
          rewtitted_from: t.rt}
        tweets= tweets.push(hash)
      end
    end
    respond_to do |format|
      format.json { render json: tweets }
    end
  end

  def new
    @tweet = Tweet.new
    @tweet.content = params[:content] 
    @tweet.user_id = current_user.id
    if @tweet.save
      render json: @tweet, status: :created, location: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  def fecha
    @fecha=Tweet.where('created_at BETWEEN ? AND ?', Time.parse(params[:fecha1]).beginning_of_day, Time.parse(params[:fecha2]).end_of_day)
    if @fecha.nil?
      render json: { message: "ningun tweet encontrado"}
    else
      tweets =  []
      @fecha.each do |t|
        hash={}
        hash={id: t.id,
          content: t.content,
          user_id: t.user_id,
          like_count: t.likes.count,
          retweets_count: t.count_rt}
        tweets= tweets.push(hash)
      end
    end
    respond_to do |format|
      format.json { render json: tweets }
    end
  end
end
