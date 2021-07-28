class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy, :retweet]
  before_action :authenticate_user!, only: [:new, :create, :edit]
  
  def index
    @tweets = Tweet.all
  end
  
  def new
    @tweet = Tweet.new
  end

    
  def edit
  
  end

  def show
    
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    
    if @tweet.save
      redirect_to '/tweets#index'
    else
      render 'new'
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end
 
    private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
  
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
