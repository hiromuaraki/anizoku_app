class SessionsController < ApplicationController
  before_action :redirect_if_already_logged_in, only: [:new, :create]
  
  def new
  end

  # def create
  #   user = User.find_by(email: params[:email].downcase)
  #   if user && user&.authenticate(params[:password])
  #     #ログイン済みにする
  #     logged_in user
  #     #現在ログインしている人のトークンを保存する
  #     remember(user)
  #     return redirect_to admin_menu_url, notice: "管理者としてログインしました！！" if validate_admin?
  #     flash[:notice] = "#{current_user.name}さん🎉  おかえりなさい〜"
  #     redirect_back_or static_pages_home_path
  #   else
  #     render :new and return
  #   end
  # end

  #ログイン認証
  def create
    # request.env['omniauth.auth']にユーザのTwitter認証情報が格納されている
    user_data = request.env['omniauth.auth']
    session[:nickname] = user_data[:info][:nickname]
    binding.pry
    # redirect_to root_path, notice: "#{session[:nickname]}さん🎉がログインしました〜"
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

end
