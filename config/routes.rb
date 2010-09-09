FirstApp::Application.routes.draw do
  get "pages/home"
  get "pages/contact"

  resources :microposts
  resources :users
  root :to => "users#index"
end
