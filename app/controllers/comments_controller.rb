# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!, :find_category_image, only: %i[create]
  after_action :logging_comments, only: [:create]
  helper_method :find_image

  def new
    @comment = Comment.new
  end

  def create
    @comment = @image.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save!
      respond_to do |format|
        format.html {redirect_to category_image_new_path(@category, @image, @comment, locale: I18n.locale), success: 'Comment created'}
        format.js
      end
    else
      render :new
    end
  end

  def all
    @comments = Comment.order(created_at: :desc).page(params[:page])
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

  def find_image(comment)
    Image.find(comment.image_id)
  end

  def logging_comments
    LoggingUserAction.new(user_id: current_user.id,
                          action_id: "#{Action.find_by_action_type('comments').id}",
                          action_path: request.original_url).save if user_signed_in?
  end

end
