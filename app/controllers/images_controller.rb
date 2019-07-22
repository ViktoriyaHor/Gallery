class ImagesController < ApplicationController

  def index
    @images = Image.take(20)
  end
  def new
    @image = Image.new
  end
  def show
    @image = Image.find(params[:id])
  end

  def create
    @category = Category.friendly.find(params[:category_id])
    if params[:image].blank?
      flash[:notice] = "You didn't select a file"
      redirect_to @category
    else
      @image = @category.images.new(image_params)
      if @image.save
        # raise hhh
        redirect_to @category
      else
        render :new
      end
    end
  end

  def destroy
    @category = Category.friendly.find(params[:category_id])
    @image = @category.images.find(params[:id])
    @image.destroy
    redirect_to category_path(@category)
  end

  private

  def image_params
    # raise qwe
    params.require(:image).permit(:src, :category_id)
  end
end
