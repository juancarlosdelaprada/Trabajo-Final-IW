Rails.application.routes.draw do

  root 'sessions#new'
  
  resources :books do
    resources :notes, only: [:create, :destroy]
  end
  
  resources :sessions, only: [:new, :create, :destroy]
  
  resources :reviewers, only: [:new, :create]

  get "/login" => "sessions#new", as: "login"
  delete "/logout" => "sessions#destroy", as: "logout"
  
  get "/signup" => "reviewers#new", as: "signup"
end