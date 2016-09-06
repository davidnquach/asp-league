Rails.application.routes.draw do

  root 'static_pages#home'

  resources :matches

  get 'redis/retry', to: 'redis#retry'
end
