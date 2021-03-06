# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_category, only: %i[show destroy]

  def index
    @categories = Category.all
  end

  def show
    @images = @category.images.page(params[:page])
    @pre_subscribe = @category.subscriptions.find { |subscription| subscription.user_id == current_user.id} if current_user
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to @category, success: I18n.t('flash.category.created')
    else
      render :new
    end
  end

  def destroy
    # current_user.categories.find(@category.id).destroy
    if current_user.id == @category.user_id
      @category.destroy
      redirect_to profile_path, success: I18n.t('flash.category.removed')
    else
      redirect_to profile_path, danger: I18n.t('flash.category.didnt_remove')
    end
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

  def find_category
    @category = Category.find_by_slug(params[:slug])
  end
end
