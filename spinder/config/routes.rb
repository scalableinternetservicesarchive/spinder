Rails.application.routes.draw do
  root :controller => 'pages', :action => 'show', :page => 'about'
end