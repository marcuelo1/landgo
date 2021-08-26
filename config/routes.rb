Rails.application.routes.draw do
  ###############################
  #######  A D M I N ############
  devise_for :admins
  
  namespace :admin do
    get "/", to: "admin#index"

    scope :category do
      get "/", to: "category#index"
      post "/", to: "category#create"
      get "/:id", to: "category#show"
    end
    
    scope :category_deal do
      post "/", to: "category_deals#create"
    end

    scope :seller do
      get "/", to: "seller#index"
      get "/new", to: "seller#new"
      post "/", to: "seller#create"
      get "/:id", to: "seller#show"
    end

    scope :product_category do
      post "/", to: "product_category#create"
    end

    scope :product do
      post "/", to: "product#create"
      get "/new", to: "product#new"
    end

    scope :product_size do
      post "/", to: "product_size#create"
    end

    scope :add_on do
      post "/", to: "add_on#create"
      post "/group", to: "add_on#group_create"
    end
  end

  namespace :v1, default: {format: :json} do
    mount_devise_token_auth_for 'Buyer', at: 'buyers', controllers: {
      registrations: 'v1/buyer/registrations',
      sessions: 'v1/buyer/sessions'
    }

    namespace :buyer do
      get 'home_page', to: 'buyer#home_page'
      get "list_of_stores", to: "buyer#list_of_stores"
      get "list_of_products", to: "buyer#list_of_products"
      get "product_details", to: "buyer#product_details"
    end

    ###############################################
    mount_devise_token_auth_for 'Seller', at: 'sellers'
  end

  default_url_options :host => "http://localhost:3000"
end
