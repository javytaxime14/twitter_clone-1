Rails.application.routes.draw do
  resources :tweets do
    post 'likes', to: 'tweets#likes'
    post 'retweet', to: 'tweets#retweet'
  end
  devise_for :users, controllers: { registrations: 'users/registrations'}
  get 'home/index'
  root to: 'home#index'
  get "/app/assets/images/orange-star.png", to: redirect('/'), constraints: lambda { |req|
  req.path.exclude? 'rails/active_storage'
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
