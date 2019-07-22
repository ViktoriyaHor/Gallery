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
    # raise hhh
    # @image = @category.images.create(src: "/uploads/image/wave_src/#{image_params[:wave_src].original_filename}",
    #                                  wave_src: image_params[:wave_src])


  end

  def destroy
    @category = Category.friendly.find(params[:category_id])
    @image = @category.images.find(params[:id])
    @image.destroy
    redirect_to categories_path(@category)
  end

  private

  def image_params
    # raise qwe
    params.require(:image).permit(:id, :wave_src)
  end
end
