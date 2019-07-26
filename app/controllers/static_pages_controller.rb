class StaticPagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    @title = 'Добро пожаловать!'
  end

  def profile
    @user = User.find(current_user.id)
  end
end
