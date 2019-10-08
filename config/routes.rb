Rails.application.routes.draw do
  resources :books
  resources :book_pages
  resources :users
end
