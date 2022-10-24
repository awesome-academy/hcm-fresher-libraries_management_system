Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"

    mount RailsAdmin::Engine => "/admin", as: "rails_admin"

    devise_scope :user do
      get "/signin", to: "devise/sessions#new"
      post "/signin", to: "devise/sessions#create"
      delete "/signout", to: "devise/sessions#destroy"

      get "/signup", to: "devise/registrations#new"
      post "/signup", to: "devise/registrations#create"
    end
    devise_for :users


    delete "/remove_book_from_cart", to: "cart_books#destroy"
    delete "/remove_cart", to: "carts#destroy"

    resources :users, only: %i(show)
    resources :books, only: %i(index show)
    resources :carts, only: %i(index create destroy)
    resources :requests, only: %i(create index show)

    namespace :admin do
      resources :requests, except: %i(new create)
      resources :users, only: :show
    end
  end

  namespace "api" do
    namespace "v1" do
      resources :books, only: %i(index show)
      resources :authors, except: %i(new edit)
    end
  end
end
