class ImagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  before_action :find_category, only: [:create, :show, :destroy]
  before_action :find_image, only: [:show, :destroy]

  def index
    # @images = Image.select("images.*, COUNT(likes.id) AS l_count").left_outer_joins(:likes).group("images.id")
    #               .order("l_count DESC").page(params[:page])
    @images = Image.select("images.*, (likes_count + comments_count) AS i_count").order("i_count DESC").page(params[:page])
  end

  def show
    @pre_like = @image.likes.find { |like| like.user_id == current_user.id}
  end

  def new
    @image = Image.new
  end

  def create
    if params[:image].blank?
      redirect_to @category, danger: I18n.t('flash.image.select')
    else
      @image = @category.images.new(image_params.merge( {user_id: current_user.id} ))
      if @image.save && @image.errors.empty?
        id = @image.id
        # Resque.enqueue(NewImageSendEmail, id)
        # raise hhh
        redirect_to @category, success: I18n.t('flash.image.saved')
      else
        render :new, danger: I18n.t('flash.image.didnt_save')
      end
    end
  end

  def destroy
    @image.destroy
    redirect_to category_path(@category), success: I18n.t('flash.image.removed')
  end

  private

  def find_category
    @category = Category.friendly.find(params[:category_slug])
  end

  def find_image
    @image = @category.images.find(params[:id])
  end

  def image_params
    params.require(:image).permit(:src, :category_id, :current_user_id)
  end

end
