class CommentsController < ApplicationController

  before_action :authenticate_user!, :find_category_image, only: [:create, :destroy]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = @image.comments.new(comment_params)
    if @comment.save
      redirect_to category_image_new_path(@category, @image, @comment), success: 'Comment created'
    else
      render :new
    end
  end

  def update
    @image = @comment.image
    @category = @image.category
    if @comment.update(comment_params)
      redirect_to category_image_new_path(@category, @image), success: 'Comment updated'
    else
      render 'edit'
    end
  end

  def destroy
    @comment.destroy
    redirect_to category_image_new_path(@category, @image), success: 'Comment removed'
  end

  def all
    @comments = Comment.order(:created_at).page(params[:page])
  end

  private

  def find_category_image
    @category = Category.friendly.find(params[:category_slug])
    @image = Image.find(params[:image_id])
  end

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

end
