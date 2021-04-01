
class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_search
  #管理者の権限かどうか
  def validate_admin?
    current_user.admin? 
  end

  def set_search
    @search = Work.ransack(params[:q])
    @items = @search.result
  end

  #ログインしているかどうか
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end