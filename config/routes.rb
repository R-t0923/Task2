Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  get 'home/about' => 'home#about',as:"home_about"
  get 'search' => 'search#search'
  resources :users,only: [:show,:index,:edit,:update] do
  get :follower
  get 'follow' =>'users#follow'
  end
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:index,:create, :destroy]
end

