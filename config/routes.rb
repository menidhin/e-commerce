Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :customers, :carts, :orders, :product_images, :categories
  resources :products do
  	resources :likes
  end	

  resources :products do 
    resources :reviews
   end 

  get "/" => "products#index"

  get "/my_account" => "customers#home", :as => :my_account
  get "/edit_account" => "customers#edit", :as => :edit_account

  get "/search" => "products#search", :as => "search_page"	

  match "/add-to-cart/:product_id" => "carts#create", :via => :post, :as => "add_to_cart" 

  get "/my_orders" => "orders#my_orders"

  get "/new_order/:cart_id" => "orders#new", :via => :get, :as => :order_new
  

  match "/buy_now/:product_id" => "carts#buy_now", :via => :post, :as => :buy_now
  
  get "/checkout" => "orders#checkout", :via => :get, :as => :checkout
  match "/checkout_submit" => "orders#checkout_submit", :via => :post, :as => :checkout_submit

  match "/delivered/:id" => "orders#delivered", :via => :put, :as => :delivered
  match "/packed/:id" => "orders#packed", :via => :put, :as => :packed
  match "/shipped/:id" => "orders#shipped", :via => :put, :as => :shipped
  match "/cancelled/:id" => "orders#cancelled", :via => :put, :as => :cancelled

end
