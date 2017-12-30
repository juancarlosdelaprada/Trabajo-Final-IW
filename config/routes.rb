Rails.application.routes.draw do
  
  resources :books do
    resources :notes, only: [:create, :destroy]
  end
  root 'books#index'
  
end
