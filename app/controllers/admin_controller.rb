class AdminController < ApplicationConroller
  before_action :validate_admin?
  
  def index
  end

  private

  def validate_admin?
    redirect_to root_url unless current_user.admin?
    redirect_to posts_path, success: "管理者がログインしました！"
  end
end