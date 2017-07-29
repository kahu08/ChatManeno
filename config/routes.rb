Rails.application.routes.draw do
  devise_for :users
  root 'chat_room#index'

  resources :chat_rooms, only: [:new, :create, :show, :index]

  #mount actionCable to a url
  mount ActionCable.server => '/cable' 
end
