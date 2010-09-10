FirstApp::Application.routes.draw do
  get "pages/home"
  get "pages/contact"
  get "pages/about"
  get "pages/help"
  
  resources :microposts
  resources :users
  root :to => "users#index"
end
