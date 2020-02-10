Rails.application.routes.draw do
  devise_for :users
  root to: "home#top"
  get 'home/about' => 'home#about',as:"home_about"
  resources :users,only: [:show,:index,:edit,:update]
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
    # post 'favorites/index_create' => 'favorites#index_create',as:"favorite_create"
    # delete 'favorites/index_destroy' => 'favorites#index_destroy',as:"favorite_destroy"
  end
  
  
end

