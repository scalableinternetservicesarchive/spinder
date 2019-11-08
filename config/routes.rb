Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  
  get 'pages/music' => 'pages#music'
  get 'pages/profile' => 'pages#profile'
  post 'song/like' => 'song#like'
end