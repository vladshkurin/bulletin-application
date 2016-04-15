class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [
      :login,
      :email,
      :full_name,
      :address,
      :city,
      :country,
      :state,
      :birthday,
      :zip
    ]
    devise_parameter_sanitizer.for(:sign_in) << [
      :login, :email, :password, :remember_me,
    ]
    devise_parameter_sanitizer.for(:sign_up) << [
      :login,
      :email,
      :password,
      :full_name,
      :address,
      :city,
      :country,
      :state,
      :birthday,
      :zip
    ]
  end
end
