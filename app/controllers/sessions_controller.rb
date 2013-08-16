class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_username(params[:username])
    if @user && @user.pass_check == params[:password]
      log_in!(@user)
      redirect_to subs_url
    else
      flash[:message] = "Invalid username or password"
      redirect_to new_session_url
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end
end
