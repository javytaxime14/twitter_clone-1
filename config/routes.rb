Rails.application.routes.draw do
  scope '/api' do
    get '/news', to: 'api#index'
    get '/:start_date/:end_date', to: 'api#show'
    post '/tweets', to: 'api#create', as: 'api_create'
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
    post 'likes', to: 'tweets#likes'
    post 'retweet', to: 'tweets#retweet'
  end
  devise_for :users, controllers: { registrations: 'users/registrations'}
  get 'home/index'
  root to: 'home#index'
  resources :users, only: [:show]
  post 'follow/:friend_id', to: 'users#follow', as: 'users_follow'
  get 'all_tweets', to: 'home#all_tweets', as: 'all_tweets'
  get '/tweets/hashtag/:name', to: 'tweets#hashtags'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
