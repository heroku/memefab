Rails.application.routes.draw do
  resources :images, only: :index
  resources :memes, only: [:new, :create]
  root 'images#index'
end
