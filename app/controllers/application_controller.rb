class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) << :username

    devise_parameter_sanitizer.for(:sign_up) << :first_name
    devise_parameter_sanitizer.for(:sign_up) << :last_name
    devise_parameter_sanitizer.for(:sign_up) << :photo
    devise_parameter_sanitizer.for(:sign_up) << :zip
    devise_parameter_sanitizer.for(:sign_up) << :state
    devise_parameter_sanitizer.for(:sign_up) << :city
    devise_parameter_sanitizer.for(:sign_up) << :unit
    devise_parameter_sanitizer.for(:sign_up) << :street
    devise_parameter_sanitizer.for(:sign_up) << :username
    devise_parameter_sanitizer.for(:sign_up) << :alcohol
    devise_parameter_sanitizer.for(:sign_up) << :body
    devise_parameter_sanitizer.for(:sign_up) << :height
    devise_parameter_sanitizer.for(:sign_up) << :weight
    devise_parameter_sanitizer.for(:sign_up) << :activity_factor
    devise_parameter_sanitizer.for(:sign_up) << :target_days
    devise_parameter_sanitizer.for(:sign_up) << :target_pounds

    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :photo
    devise_parameter_sanitizer.for(:account_update) << :zip
    devise_parameter_sanitizer.for(:account_update) << :state
    devise_parameter_sanitizer.for(:account_update) << :city
    devise_parameter_sanitizer.for(:account_update) << :unit
    devise_parameter_sanitizer.for(:account_update) << :street
    devise_parameter_sanitizer.for(:account_update) << :username
    devise_parameter_sanitizer.for(:account_update) << :alcohol
    devise_parameter_sanitizer.for(:account_update) << :body
    devise_parameter_sanitizer.for(:account_update) << :height
    devise_parameter_sanitizer.for(:account_update) << :weight
    devise_parameter_sanitizer.for(:account_update) << :activity_factor
    devise_parameter_sanitizer.for(:account_update) << :target_days
    devise_parameter_sanitizer.for(:account_update) << :target_pounds
  end
end
