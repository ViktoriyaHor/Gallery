# frozen_string_literal: true

class ImagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_category, only: %i[create show destroy]
  before_action :find_image, only: %i[show destroy]
  before_action :find_category_by_id, only: [:extended_create]
  before_action :create_common, only: %i[create extended_create]
  before_action :new_common, only: %i[new extended_new]
  before_action :find_category_all, only: [:extended_new]

  def index
    @images = Image.select('images.*, (likes_count + comments_count) AS i_count').order('i_count DESC').page(params[:page])
  end

  def show
    @pre_like = @image.likes.find { |like| like.user_id == current_user.id }
  end

  def new
  end

  def create
  end

  # def destroy
  #   @image.destroy
  #   redirect_to category_path(@category), success: I18n.t('flash.image.removed')
  # end

  def extended_new
  end

  def extended_create
    @category = Category.find(image_params[:category_id])
  end

  private

  def find_category
    @category = Category.friendly.find(params[:category_slug])
  end

  def find_category_by_id
    @category = Category.find(image_params[:category_id])
  end

  def find_category_all
    @category_all = Category.all
  end

  def find_image
    @image = @category.images.find(params[:id])
  end
  def new_common
    @image = Image.new
  end
  def create_common
    if params[:image].blank?
      redirect_to @category, danger: I18n.t('flash.image.select')
    else
      @image = @category.images.new(image_params.merge( { user_id: current_user.id } ))
      if @image.save && @image.errors.empty?
        id = @image.id
        Resque.enqueue(NewImageSendEmail, id)
        redirect_to @category, success: I18n.t('flash.image.saved')
      else
        render :new, danger: I18n.t('flash.image.didnt_save')
      end
    end
  end

  def image_params
    params.require(:image).permit(:src, :category_id, :current_user_id)
  end

end
