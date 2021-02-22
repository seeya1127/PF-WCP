Rails.application.routes.draw do
  root to: 'homes#top'
resources :posts do
  resource :favorites, only: [:create, :destroy]
  resource :comments, only: [:create, :destroy]
end

get "/home_posts", to: "posts#home_posts"
get "/shop_posts", to: "posts#shop_posts"

devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    passwords: "users/passwords",
  }

resources :users do
  resource :relationships, only: [:create, :destroy]
  get :follows, on: :member
  get :followers, on: :member
end

get "chat/:id" => "chats#show", as: "chat"
resources :chats, only: [:create]

resources :tags do
  get "posts", to: "posts#search"
end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :notifications, only: :index
end
