Rails.application.routes.draw do
  resources :posts do 
    resources :likes
    resources :comments
  end
  get 'users/index'
  get 'users/show'
  devise_for :users
  root 'public#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
