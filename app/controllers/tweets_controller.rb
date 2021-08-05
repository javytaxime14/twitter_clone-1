class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit]
  before_action :set_current_tweet, only: [:likes, :retweet]
  
  def index
    @q = Tweet.order('created_at DESC').page(params[:page]).ransack(params[:q])
    @tweets = @q.result(distinct: true)
  end
  
  def new
    @tweet = Tweet.new
  end

  def likes
    if @tweet.is_liked?(current_user)
      @tweet.unlike(current_user)  
    else
      @tweet.like(current_user)
    end
    redirect_to root_path
  end

  def retweet
   Tweet.create(content: @tweet.content, user_id: current_user.id, rt_ref: @tweet.id) 
    redirect_to root_path
  end

  def hashtags
    @q = Tweet.order('created_at DESC').page(params[:page]).ransack(params[:q])
    @tweets = @q.result(distinct: true)

    if params[:q].blank?
    tag = Tag.find_by(name: params[:name]) 
    @tweets = tag.tweets
    end
  end
    
  def edit
  
  end

  def show
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user
    
    if @tweet.save
      redirect_to root_path
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
  
  def set_current_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def tweet_params
    params.require(:tweet).permit(:content, :rt_ref)
  end
end
