class CategoriesController < ApplicationController

  before_action :find_category, only: [:update, :edit, :show, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def show
    @images = Image.where(category_id:"#{@category.id}")
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category
    else
      # raise ff
      render :new
    end
  end

  def update
    if @category.update(title: category_params[:title], slug: category_params[:title])
      # raise qwe
      redirect_to @category
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path
    else
      redirect_to categories_path, error: 'Not delete'
    end
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

  def find_category
    @category = Category.friendly.find(params[:id])
  end

end

