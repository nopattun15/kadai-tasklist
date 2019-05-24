class ApplicationController < ActionController::Base
    
    include SessionsHelper
    
    private
    
    def require_user_logged_in
        unless logged_in?
            redirect_to login_url
        end 
    end 
    
    def login(email, password)
        @user = User.find_by(email: email)
        if @user && @user.authenticate(password)
          session[:user_id] = @user.id
          return true
        else
          return false
        end 
    end 
end
