class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :image, :image_cache])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username, :image, :image_cache, :remove_image])
  end
end
