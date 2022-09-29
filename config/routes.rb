Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    get "/signup", to: "users#new"
    post "/signup", to: "users#create"

    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    delete "/remove_book_from_cart", to: "cart_books#destroy"
    delete "/remove_cart", to: "carts#destroy"

    resources :users, only: %i(new create show)
    resources :books, only: %i(index show)
    resources :carts, only: %i(index create destroy)
    resources :requests, only: %i(create index show)
  end
end
