class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :update_sanitized_params, if: :devise_controller?
  around_filter :user_time_zone, :if => :current_user
    
    private 
    
    def update_sanitized_params
      devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:nickname, :username, :provider, :url, :email, :password, :timezone, :password_confirmation)}
      devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:nickname, :username, :email, :password, :password_confirmation, :timezone, :current_password)}
    end
    
    def user_time_zone(&block)
      Time.use_zone(current_user.timezone, &block)
    end
end
