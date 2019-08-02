class ApplicationController < ActionController::Base

  add_flash_types :success, :danger

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :rating_categories

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  def after_sign_in_path_for(users)
    stored_location_for(users) || categories_path
  end

  def rating_categories
    @categories = Category.limit(3)
  end
end
