Rails.application.routes.draw do
  resources :stores

  devise_for :users

  get    '/products/new',      to: 'products#new',     as: :new_product
  post   '/products',          to: 'products#create'
  get    '/products/:id',      to: 'products#show',    as: :product
  get    '/products/:id/edit', to: 'products#edit',    as: :edit_product
  patch  '/products/:id',      to: 'products#update'
  delete '/products/:id',      to: 'products#destroy'

  get '/carts/:id', to: 'carts#show', as: :cart

  post 'cart_items', to: 'cart_items#create', as: :cart_items

  delete '/cart_products/:id', to: 'cart_products#destroy', as: :remove_cart_product

  root "home#index"
end
