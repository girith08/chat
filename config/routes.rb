Rails.application.routes.draw do
  devise_for :users

  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end

  resources :direct_messages
  resources :private_chatrooms

  root to: 'chatrooms#index'
end