module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !!current_user
  end

  def if_not_logged_in
    render "" ,danger:"ログインしてください" if logged_in?
  end

  def log_out
    session.delete(:user_id)
    current_user = nil
  end
  
end