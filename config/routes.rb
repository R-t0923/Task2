Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  get 'home/about' => 'home#about',as:"home_about"
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  
  
end

