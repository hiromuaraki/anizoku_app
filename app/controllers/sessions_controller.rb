class SessionsController < ApplicationController
  before_action :redirect_if_already_logged_in, only: :create

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
    user_data = request.env['omniauth.auth']
    return if user_data.blank? || user_data.nil?
    user = User.find_by(uid: user_data[:uid], provider: user_data[:provider])
    unless user
      @user = User.new(
        uid: user_data[:uid],
        provider: user_data[:provider],
        name: user_data[:info][:name],
        nickname: user_data[:info][:nickname],
        admin: false,
        image: !user_data[:info][:image].blank? ? user_data[:info][:image] : "",
        url: user_data[:info][:urls][:Twitter]
      )
      @user.build_user_profile
      msg = "#{user_data[:info][:nickname]}さん🎉がログインしました〜" if @user.save!
      @user_id = User.find_by(uid: user_data[:uid]).id
    else
      msg = "#{user_data[:info][:nickname]}さん,おかえりなさい〜"
      @user_id = user.id
    end
    logged_in @user_id
    redirect_to static_pages_home_path, notice: msg
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

end
