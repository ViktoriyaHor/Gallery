class ImagesController < ApplicationController

  before_action :find_category, only: [:create, :show, :destroy]
  before_action :find_image, only: [:show, :destroy]

  def index
    @images = Image.all.page(params[:page])
  end

  def show
  end

  def new
    @image = Image.new
  end

  def create
    if params[:image].blank?
      redirect_to @category, danger: "Image didn't save! Please select a file"
    else
      @image = @category.images.new(image_params)
      @image.save
      redirect_to @category, success: "Image saved"
    end
  end

  def destroy
    @image.destroy
    redirect_to category_path(@category), success: "Image removed"
  end

  private

  def find_category
    @category = Category.friendly.find(params[:category_slug])
  end

  def find_image
    @image = @category.images.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:src, :category_id)
  end

end
