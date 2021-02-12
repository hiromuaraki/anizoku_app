class UsersController < ApplicationController
  before_action :logged_in?

  def new
    @user = User.new
  end

  def create
    #すでに入部済みかどうかの確認
    user = User.find_by(email: params[:user][:email].downcase)
    if !user
      @user = User.new(user_params)
      #新規ユーザー情報のプロフィール情報と紐付け
      @user.build_user_profile
      logged_in @user if @user.save!
      redirect_to root_url, success: "ようこそ、あに族へ！！"
    else
      return render "new", danger: "入部に失敗しました。"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name)
  end
end
