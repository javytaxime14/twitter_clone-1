class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit]
  
  def index
    #@tweets = Tweet.all
    @tweets = Tweet.order(created_at: :desc).page params[:page]
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
