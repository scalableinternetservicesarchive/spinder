Rails.application.routes.draw do
  root :controller => 'pages', :action => 'show', :page => 'about'
  devise_for :users
  
  get 'pages/music' => 'pages#music'
end