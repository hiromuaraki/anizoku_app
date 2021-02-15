class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def create
    #すでに入部済みかどうかの確認
    @user = User.new(user_params)
    #エラーが発生した場合
    render "new" and return if @user.invalid?
    if !User.find_by(email: params[:email]&.downcase)
      @user.build_user_profile
      if @user.save
        logged_in @user
        redirect_to static_pages_home_path, notice: "ようこそ、あに族へ！！"
      else
        render :new, alert: "登録に失敗しました" and return
      end
    end
  end

  private

  def user_params
    params.permit(:email, :password, :name)
  end
end
