class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def check_session
    flash[:message] = "Please log in before viewing that page" unless logged_in?
    redirect_to new_session_url unless logged_in?
  end
end
