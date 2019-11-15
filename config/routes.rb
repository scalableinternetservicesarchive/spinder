Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  
  get 'pages/music' => 'pages#music'
  get 'pages/profile' => 'pages#profile'
  get 'pages/messages' => 'pages#messages'
  post 'song/like' => 'song#like'
end