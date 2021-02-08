Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root to: 'homes#top'
resources :posts do
  resource :favorites, only: [:create, :destroy]
  resource :comments, only: [:create, :destroy]
end

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
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
