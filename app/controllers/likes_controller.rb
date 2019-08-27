class LikesController < ApplicationController

  before_action :authenticate_user!, :find_image
  before_action :find_like, only: [:destroy]
  after_action :logging_likes, only: [:create, :destroy]

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

  def pre_like
    @pre_like = @image.likes.find { |like| like.user_id == current_user.id}
  end

  def logging_likes
    LoggingUserAction.new(:user_id=>current_user.id, :action_id=>"#{Action.find_by_action_type('likes').id}", :action_path=>request.original_url).save if user_signed_in?
  end
end
