include SessionsHelper

class ApplicationController < ActionController::Base

  #管理者の権限かどうか
  def validate_admin?
    current_user.admin? 
  end

  #ログインしているかどうか
  def logged_in_user
    unless logged_in?
      store_location
      redirect_to login_path, alert: "ログインしてください"
    end
  end
end