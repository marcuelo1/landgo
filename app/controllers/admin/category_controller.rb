class Admin::CategoryController < ApplicationController
    before_action :authenticate_admin!
    before_action :set_admin

    def index
        
    end
    
end
