# frozen_string_literal: true

class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @images = Image.select('images.*, (likes_count + comments_count) AS i_count').order('i_count DESC').limit(6)
    @categories = Category.all.limit(6)
  end

  def profile
    @user = User.find(current_user.id)
    @categories = @user.categories
  end

end
