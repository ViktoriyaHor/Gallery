# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :success, :danger

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :navigation, only: %i[index show all]

  before_action :set_locale

  helper_method :rating_categories
  helper_method :popular_image

  def self.default_url_options(options = {})
    options.merge( locale: I18n.locale )
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end

  private

  def rating_categories
    @category = Category.left_outer_joins(:images).select('categories.*, (sum(images.likes_count + images.comments_count)+subscriptions_count) AS c_count').order('c_count DESC NULLS LAST').group('id').limit(5)
  end

  def popular_image(category)
    Category.find(category).images.select('images.*, (likes_count + comments_count) AS i_count').order('i_count DESC').first
  end

  def navigation
    LoggingUserAction.new(user_id: current_user.id, action_id: "#{Action.find_by_action_type('navigation').id.to_s}", action_path: request.original_url).save if user_signed_in?
  end

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
end
