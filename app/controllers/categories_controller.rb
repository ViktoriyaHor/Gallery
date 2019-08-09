class CategoriesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_category, only: [:update, :edit, :show, :destroy]

  def index
    @categories = Category.all
  end

  def show
    @images = @category.images.page(params[:page])
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
      redirect_to categories_path, success: 'Category removed'
    else
      redirect_to categories_path, danger: "Category not yours"
    end
  end

  private

  def category_params
    params.require(:category).permit(:title, :slug)#.merge( {user_id: current_user.id} )
  end

  def find_category
    @category = Category.find_by_slug(params[:slug])
  end

end

