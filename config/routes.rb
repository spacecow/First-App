FirstApp::Application.routes.draw do
  match '/signup', :to => 'users#new'
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'
  
  resources :microposts
  resources :users
  root :to => "pages#home"
end
