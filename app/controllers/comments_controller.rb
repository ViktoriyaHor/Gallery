class CommentsController < ApplicationController

  before_action :find_category_image, only: [:create, :destroy]

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
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
    @comment = Comment.find(params[:id])
    @image = Image.find(@comment.image_id)
    @category = Category.find(@image.category_id)
    if @comment.update(commenter: comment_params[:commenter], body: comment_params[:body])
      redirect_to category_image_new_path(@category, @image), success: 'Comment updated'
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
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

end
