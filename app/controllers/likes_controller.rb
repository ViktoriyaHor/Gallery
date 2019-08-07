class LikesController < ApplicationController

  before_action :find_image
  before_action :find_like, only: [:destroy]

  def create
    @image.likes.create(user_id: current_user.id) unless already_liked?
    redirect_to category_image_path(@category, @image)
  end

  def destroy
    if already_liked?
      @like.destroy
    end
    redirect_to category_image_path(@category, @image)
  end
  private

  def find_image
    @image = Image.find(params[:image_id])
    @category = Category.find(@image.category_id)
  end

  def already_liked?
    Like.where(user_id: current_user.id, image_id:
        params[:image_id]).exists?
  end

  def find_like
    @like = @image.likes.find(params[:id])
  end
end
