class LinksController < ApplicationController
  before_filter :check_session, only: [:new, :create, :edit, :update, :destroy]
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
    params[:link].each do |_, link|
      @link.update_attributes(link)
    end
    redirect_to link_url(@link)
  end
end
