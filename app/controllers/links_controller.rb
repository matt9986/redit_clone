class LinksController < ApplicationController
  before_filter :check_session, except: [:show]
  def new
    @link = Link.new(sub_id: params[:sub_id])
    render :new
  end

  def create
    p params
    params[:link].each do |_, link|
      @link = Link.new(link)
      @link.user_id = current_user.id
      @link.sub_id = params[:sub_id]
    end
    if @link.save
      redirect_to link_url(@link)
    else
      render :new
    end
  end

  def show
    @link = Link.find(params[:id])
    @comments_by_parent = @link.comments_by_parent
    render :show
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to sub_url(@link.sub)
  end

  def edit
    @link = Link.find(params[:id])
    unless @link.user_id == current_user.id
      redirect_to link_url(@link)
    else
      render :edit
    end
  end

  def update
    @link = Link.find(params[:id])
    if @link.user_id == current_user.id
      params[:link].each do |_, link|
        @link.update_attributes(link)
      end
      params[:comment_ids].each{ |id| Comment.find(id).destroy}
    end
    redirect_to link_url(@link)
  end

  def upvote
    create_vote(current_user.id, params[:id], 1)
    redirect_to link_url(params[:id])
  end

  def downvote
    create_vote(current_user.id, params[:id], -1)
    redirect_to link_url(params[:id])
  end


  def create_vote(user_id, link_id, value)
  if vote = Vote.find_by_user_id_and_link_id(user_id, link_id)
    vote.update_attributes(value: value)
  else
    vote = Vote.new(user_id: user_id, link_id: link_id, value: value)                
    vote.save
  end
  vote
  end
end
