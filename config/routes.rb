Rails.application.routes.draw do
  resources :tweets
  devise_for :users, controllers: { registrations: 'users/registrations'}
  get 'home/index'
  get 'login', to: 'sessions#new', as: 'login'
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
