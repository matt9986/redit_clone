class UsersController < ApplicationController
  before_filter :check_session, only: [:index, :destroy]
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      log_in!(@user)
      redirect_to subs_url
    else
      flash.now[:message] = "Did you forget a field?"
      render :new
    end
  end

  def index
    render :index
  end

  def destroy
    current_user.destroy
    flash[:message] = "#{current_user.username} was deleted"
    redirect_to new_user_url
  end

end
