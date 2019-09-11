# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :find_category, :authenticate_user!
  before_action :find_subscription, only: [:destroy]

  def create
    @subscription = @category.subscriptions.new(user_id: current_user.id) unless already_subscribe?
    if @subscription.save
      email = User.find(@subscription.user_id).email
      username = User.find(@subscription.user_id).username
      category = Category.find(@subscription.category_id).slug
      Resque.enqueue(ToSubscribersSendEmail, [email, username, category])
      redirect_to category_path(@category)
    else
      redirect_to category_path(@category), danger: I18n.t('flash.subscription.didnt_create')
    end
  end

  def destroy
    @subscription.destroy if already_subscribe?
    redirect_to category_path(@category)
  end

  private

  def find_category
    @category = Category.friendly.find(params[:category_slug])
  end

  def find_subscription
    find_category
    @subscription = @category.subscriptions.find(params[:id])
  end

  def already_subscribe?
    Subscription.where(user_id: current_user.id, category_id: @category.id).exists?
  end

end
