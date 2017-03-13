class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache, :remove_avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache, :remove_avatar])
  end

  def authenticate_admin!
    unless user_signed_in? && current_user.admin?
      redirect_to root_path, notice: "You're not an admin, pal"
    end
  end
end
