Rails.application.routes.draw do
  ###############################
  #######  A D M I N ############
  devise_for :admins
  
  namespace :admin do
    get "/", to: "admin#index"

    resources :category do
    end
    
    scope :category_deal do
      post "/", to: "category_deals#create"
    end

    resources :seller do
    end

    scope :product_category do
      post "/", to: "product_category#create"
      get "/new", to: "product_category#new"
    end

    scope :product do
      post "/", to: "product#create"
      get "/new", to: "product#new"
      get "/:id", to: "product#show"
    end

    scope :product_size do
      post "/", to: "product_size#create"
      get "/new", to: "product_size#new"
    end

    resources :add_ons do
    end

    resources :add_on_groups do
    end

    resources :vouchers do
    end

    resources :buyers do
    end

    resources :riders do
    end
  end

  namespace :v1, default: {format: :json} do
    #############################
    #### B U Y E R ##############
    mount_devise_token_auth_for 'Buyer', at: 'buyers', controllers: {
      registrations: 'v1/buyer/registrations',
      sessions: 'v1/buyer/sessions'
    }

    namespace :buyer do
      resources :buyers, except: [:show], path: "" do
        collection do
          get :home_page
          get :product_details
          get :is_signed_in
          get :check
          get :review_payment_location
        end
      end

      resources :sellers do
      end

      resources :carts do
        collection do
          get :list_of_sellers
        end
      end

      resources :checkouts do
        collection do
          get :current_transactions
        end
      end

      resources :locations do
        collection do
          post :select_location
        end
      end

      resources :payment_methods do
        collection do
          post :select_payment_method
        end
      end
      
      resources :vouchers

      resources :search, only: [:index] do
        collection do
          get :suggestion_words
        end
      end
    end
    ### E N D  O F  B U Y E R ###
    #############################

    #############################
    #### R I D E R ##############
    mount_devise_token_auth_for 'Rider', at: 'riders'

    namespace :rider do
      resources :riders do
        collection do
          get :home
        end
      end
    end
    ### E N D  O F  R I D E R ###
    #############################

    ###############################################
    mount_devise_token_auth_for 'Seller', at: 'sellers'
  end

  # default_url_options :host => "http://192.168.1.9:3000"
  # default_url_options :host => "https://landgo.herokuapp.com"
  default_url_options :host => "http://localhost:3000"
end
