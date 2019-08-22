class SubscriptionsController < ApplicationController

  before_action :find_category, :authenticate_user!
  before_action :find_subscription, only: [:destroy]

  def create
    @category.subscriptions.create(user_id: current_user.id) unless already_subscribe?
    redirect_to category_path(@category)
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
