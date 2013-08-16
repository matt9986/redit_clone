class CommentsController < ApplicationController
  before_filter :login_check
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.save!
    redirect_to link_url(@comment.link)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to link_url(@comment.link)
  end

  private

  def login_check
    unless logged_in?
      flash[:message]= "You must be logged in to comment"
      redirect_to new_session_url
    end
  end
end
