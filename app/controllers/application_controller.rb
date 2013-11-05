class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    
  # for cancan
  # If the user authorization fails, a CanCan::AccessDenied exception will be raised
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  # for devise parameters
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  # is there any more beautiful method to deal with ?
  # i think these codes are ugly that if i add some attribute , i need add them here once and once.
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login,:email) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password) }
  end
end
