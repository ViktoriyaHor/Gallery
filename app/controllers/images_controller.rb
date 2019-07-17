class ImagesController < ApplicationController

  def index
    @images = Image.take(20)
  end
  def show
    @image = Image.find(params[:id])
  end
  # def new
  #
  # end
end
