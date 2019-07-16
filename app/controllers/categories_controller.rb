class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.friendly.find(params[:id])
    @images = Image.where(category_id:"#{@category.id}")
  end

  private
  def cetegories_params
    params.require(:category).permit(:title)
  end
end
