Rails.application.routes.draw do
  root 'books#show'
  resources :books
end
