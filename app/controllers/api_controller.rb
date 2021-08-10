class ApiController < ApplicationController
      skip_before_action :verify_authenticity_token

    def index
        array = []
        Tweet.all.each do |tweet|
            array << {:id => tweet.id, :content => tweet.content, :user_id => tweet.user_id, :likes_count => tweet.likes.count, :retweets_count => tweet.rt_count, :retweeted_from => (tweet.rt_ref.nil? ? '-' : tweet.rt_ref)} 
        end
        @tweets = array
        render json: @tweets.last(50) 
    end

    def show
        @tweets = Tweet.all
        render json: @tweets.where("DATE(created_at) >= :start_date AND DATE(created_at) <= :end_date", {start_date: params[:start_date], end_date: params[:end_date]})
    end

    def create
        
        user = User.authenticate(params[:user][:email], params[:user][:password])
        if user.nil?
            render json: { error: 'Invalid credentials' }
            return
        end

        @tweet = Tweet.new(tweet_params)
        @tweet.user = user
    
        if @tweet.save
            render json: @tweet, status: :created
        else
            render json: @tweet.errors, status: :unprocessable_entity
        end
    end
    

    private
    def tweet_params
        params.require(:tweet).permit(:content)
    end
end