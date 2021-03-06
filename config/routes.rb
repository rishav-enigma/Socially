Rails.application.routes.draw do
  get 'friendships/create'
  get 'friendships/destroy'
  resources :posts do 
    resources :likes
    resources :comments
  end
  get 'users/index'
  get 'users/show'
  get 'users/posts'
  get 'search_friend', to: 'users#search'
  devise_for :users
  root 'public#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
