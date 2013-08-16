class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @comment.save!
    redirect_to link_url(@comment.link)
  end

  def destroy
    @comment.find(params[:id])
    @comment.destroy
    redirect_to link_url(@comment.link)
  end
end
