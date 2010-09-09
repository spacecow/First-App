FirstApp::Application.routes.draw do
  resources :microposts

  resources :users
  root :to => "users#index"
end
