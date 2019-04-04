class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include SessionsHelper
  include BooksHelper
  include PublicActivity::StoreController
  include CanCan::ControllerAdditions

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = t "not_allow"
    redirect_to root_path
  end

  protected

  def logged_in_user
    return if user_signed_in?
    store_location
    flash[:danger] = t "login_plz"
    redirect_to new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up do |user_params|
      user_params.permit :name, :email, :password,
        :password_confirmation, :phone, :address, :role
    end
    devise_parameter_sanitizer.permit :account_update do |user_params|
      user_params.permit :name, :email, :password,
        :password_confirmation, :current_password, :phone, :address, :role
    end
  end
end
