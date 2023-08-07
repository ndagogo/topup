class ApplicationController < ActionController::Base
    #This hadles the username and phone number that was added by custom
    #To the user registration form
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :authenticate_user!
    
    protected
    
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone_number, :referrer_code])
    end
      
   
end
