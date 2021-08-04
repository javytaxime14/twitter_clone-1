class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  
  def index
    @q = Tweet.includes([:user, :likes]).order('created_at DESC').page(params[:page]).ransack(params[:q])
    @tweets = @q.result(distinct: true)

    if signed_in? && current_user.friends.count > 0
      @tweets = Tweet.tweets_for_me(current_user).order(created_at: :desc).page params[:page]
    else
      @tweets = Tweet.order(created_at: :desc).page params[:page]
    end
    @tweet = Tweet.new
  end

  def all_tweets
    @tweets = Tweet.order(created_at: :desc).page params[:page]
    @tweet = Tweet.new

    render "index"
  end

  def likes
    if @tweet.is_liked?(current_user)
      @tweet.unlike(current_user)  
    else
      @tweet.like(current_user)
    end
    redirect_to root_path
  end
end
