Rails.application.routes.draw do
  resources :images, only: :index
  resources :memes, only: [:new, :create, :show]
  root 'images#index'
end
