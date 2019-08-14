class ApplicationController < ActionController::Base

  add_flash_types :success, :danger

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :navigation, only: [:index, :show]

  helper_method :rating_categories

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  private

  def rating_categories
    # @categories = Category.select("categories.*, (COUNT(images.id)+COUNT(comments.id)+COUNT(likes.id)) AS i_count")
    #                   .left_outer_joins(:images, images: [:comments, :likes]).group("categories.id")
    #                   .order("i_count DESC").limit(5)
    @category = Category.select("categories.*, (likes_count + comments_count + subscriptions_count) AS c_count")
                    .joins(:images).order("c_count DESC").limit(5)
  end

  def navigation
    LoggingUserAction.new(:user_id=>current_user.id, :action_id=>"#{Action.find_by_action_type('navigation').id}", :action_path=>request.original_url).save if user_signed_in?
  end
end
