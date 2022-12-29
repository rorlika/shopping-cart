# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products do
    resources :price_rules
  end
  resource :carts, only: %i[show create destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'products#index'
end
