# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  after_action :action_sign_in, only: [:create]
  before_action :action_sign_out, only: [:destroy]

  def create
    flash.clear

    user = User.find_by_email(sign_in_params['email'])

    super and return unless user
    adjust_failed_attempts user

    super and return if (user.failed_attempts < User.logins_before_captcha)
    super and return if verify_recaptcha

    # Don't increase failed attempts if Recaptcha was not passed
    decrement_failed_attempts(user) if recaptcha_present?(params) and
           !verify_recaptcha

    # Recaptcha was wrong
    self.resource = resource_class.new(sign_in_params)
    sign_out
    flash[:error] = 'Captcha was wrong, please try again.'
    respond_with_navigational(resource) { render :new }
  end

  def destroy
    super
  end

  private
  def adjust_failed_attempts(user)
    if user.failed_attempts > user.cached_failed_attempts
      user.update cached_failed_attempts: user.failed_attempts
    else
      increment_failed_attempts(user)
    end
  end

  def after_sign_in_path_for(user)
    user.update cached_failed_attempts: 0, failed_attempts: 0
    stored_location_for(user) || categories_path
  end

  def increment_failed_attempts(user)
    user.increment :cached_failed_attempts
    user.update failed_attempts: user.cached_failed_attempts
  end

  def decrement_failed_attempts(user)
    user.decrement :cached_failed_attempts
    user.update failed_attempts: user.cached_failed_attempts
  end

  def recaptcha_present?(params)
    params[:recaptcha_challenge_field]
  end

  def action_sign_in
    LoggingUserAction.new(:user_id=>current_user.id, :action_id=>"#{Action.find_by_action_type('user sign in').id}", :action_path=>request.original_url).save if user_signed_in?
  end

  def action_sign_out
    LoggingUserAction.new(:user_id=>current_user.id, :action_id=>"#{Action.find_by_action_type('user sign out').id}", :action_path=>request.original_url).save if user_signed_in?
  end

  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
