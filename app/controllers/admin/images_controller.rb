class Admin::ImagesController < ApplicationController
  def index
  end
  
  def new
    @admin_post = AdminPost.new
  end

  def show
  end

  #画像の保存をする
  def create
    image = AdminPost.new(image_params)
    render :index and return if image.save!
  end

  def update
  end

  def destroy
  end

  private

  def image_params
    params.permit(:title, :image)
  end

end
