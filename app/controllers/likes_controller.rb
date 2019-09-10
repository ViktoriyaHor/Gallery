class LikesController < ApplicationController

  before_action :authenticate_user!, :find_image
  before_action :find_like, only: [:destroy]
  after_action :logging_likes, only: [:create, :destroy]

  def create
    @like = @image.likes.new(user_id: current_user.id) unless already_liked?
    if @like.save
      # respond_to do |format|
      #   format.html {redirect_to category_image_path(@category, @image)}
      #   format.js #render likes/create.js.haml
      # end
      redirect_to category_image_path(@category, @image)
    end

  end

  def destroy
    if already_liked?
      @like.destroy
      # respond_to do |format|
      #   format.html {redirect_to category_image_path(@category, @image)}
      #   format.js #render likes/destroy.js.haml
      # end
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
