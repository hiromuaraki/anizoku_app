module SessionsHelper
  # ユーザーのセッションを永続的にする
  def remember(user_id)
    # user.remember
    # cookies.permanent[:remember_token] = user.remember_token
    cookies.permanent.signed[:user_id] = user_id
  end

  # 記憶トークンcookieに対応するユーザーを返す
  # def current_user
  #   if (user_id = session[:user_id])
  #     @current_user ||= User.find_by(uid: user_id)
  #   elsif(user_id = cookies.signed[:user_id])
  #     user = User.find_by(uid: user_id)
  #     if user
  #       logged_in user
  #       @current_user = user
  #     end
  #   end
  # end

  #ログインしているか確認し現在ログインユーザーを返す
  def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  #ログイン済みにする
  def logged_in(user_id)
    session[:user_id] = user_id
  end

  #ログインしているか
  def logged_in?
    !!current_user
  end

  def if_not_logged_in?
    redirect_to login_path ,alert:"ログインしてください" if logged_in?
  end

  def redirect_if_already_logged_in
    if logged_in?
      redirect_to static_pages_home_path, notice: "すでにログインしています"
    end
  end

  # def forget(user)
  #   cookies.delete(:user_id)
  #   cookies.delete(:remember_token)
  # end

  def log_out
    # forget(current_user)
    session.delete(:user_id)
    current_user = nil
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end
  
end