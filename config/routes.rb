Rails.application.routes.draw do
  ###############################
  #######  A D M I N ############
  devise_for :admins
  
  scope :admin do
    get "/", to: "admin#index"
  end
end
