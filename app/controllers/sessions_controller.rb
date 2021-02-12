class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user&.authenticate(params[:password])
      #ログイン済みにする
      logged_in user
      redirect_to admin_posts_url, success: "ADMINとしてログインしました！！" if validate_admin?
      redirect_to static_pages_home_path, success: "ログインしました！！"
    else
      return render "new"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
