Rails.application.routes.draw do
  ###############################
  #######  A D M I N ############
  devise_for :admins
  
  namespace :admin do
    get "/", to: "admin#index"

    scope :category do
      get "/", to: "category#index"
    end
  end
end
