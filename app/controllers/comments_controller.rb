class CommentsController < ApplicationController

  def create
    @category = Category.friendly.find(params[:category_slug])
    @image = Image.find(params[:image_id])
    @comment = @image.comments.new(comment_params)
    if @comment.save
      redirect_to category_image_path(@category, @image)
    else
      render :new
    end
  end

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    @image = Image.find(@comment.image_id)
    @category = Category.find(@image.category_id)
    if @comment.update(commenter: comment_params[:commenter], body: comment_params[:body])
      redirect_to category_image_path(@category, @image)
    else
      render :edit
    end
  end

  def destroy
    @category = Category.friendly.find(params[:category_slug])
    @image = Image.find(params[:image_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to category_image_path(@category, @image)
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
