class ApiController < ApplicationController
  http_basic_authenticate_with name: "user", password: "user123", only: :new

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
