module SessionsHelper
  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end

  def logged_in?
    !!current_user
  end

  def log_out!
    current_user.reset_session!
    session[:token] = nil
  end

  def log_in!(user)
    session[:token] = user.reset_session!
  end
end
