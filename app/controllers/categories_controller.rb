class CategoriesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_category, only: [:update, :edit, :show, :destroy]
  helper_method :popular_image

  def index
    @categories = Category.all
    # unless current_user.blank?
    #   @subscription = Subscription.find_by_user_id(current_user)
    #   @category = @subscription.category_id unless @subscription.blank?
    # end
  end

  def show
    @images = @category.images.page(params[:page])
    @pre_subscribe = @category.subscriptions.find { |subscription| subscription.user_id == current_user.id} if current_user
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to @category, success: 'Category created'
    else
      render :new, danger: "Category didn't creat"
    end
  end

  def update
    if @category.update(title: category_params[:title], slug: category_params[:title])
      redirect_to @category, success: 'Category updated'
    else
      render :edit, danger: "Category didn't update"
    end
  end

  def destroy
    # current_user.categories.find(@category.id).destroy
    if current_user.id == @category.user_id
      @category.destroy
      redirect_to profile_path, success: 'Category removed'
    else
      redirect_to profile_path, danger: "Category not yours"
    end
  end

  private

  def category_params
    params.require(:category).permit(:title, :slug)#.merge( {user_id: current_user.id} )
  end

  def find_category
    @category = Category.find_by_slug(params[:slug])
  end

  def popular_image(category)
    Category.find(category).images.select("images.*, (likes_count + comments_count) AS i_count").order("i_count DESC").first
  end

end

