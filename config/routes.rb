Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


resources :conversations do
  resources :messages
end

  get 'pages/music' => 'pages#music'
  get 'pages/profile' => 'pages#profile'
  get 'pages/messages' => 'conversations#index'
  post 'song/like' => 'song#like'
  post 'song/dislike' => 'song#dislike'
end
