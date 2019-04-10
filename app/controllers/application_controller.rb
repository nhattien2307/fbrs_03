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
    added_attrs = [:name, :address, :phone]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
