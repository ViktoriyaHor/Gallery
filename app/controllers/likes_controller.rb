class LikesController < ApplicationController

  before_action :find_image

  def create
    @image.likes.create(image_id: params[:image_id])
    redirect_to category_image_path(@category, @image)
  end

  private

  def find_image
    @image = Image.find(params[:image_id])
    @category = Category.find(@image.category_id)
  end

end
