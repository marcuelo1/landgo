Rails.application.routes.draw do
  ###############################
  #######  A D M I N ############
  devise_for :admins
  
  namespace :admin do
    get "/", to: "admin#index"

    scope :category do
      get "/", to: "category#index"
      post "/", to: "category#create"
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
    end
  end

  default_url_options :host => "http://localhost:3000"
end
