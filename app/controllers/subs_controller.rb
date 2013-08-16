class SubsController < ApplicationController
  before_filter :check_session, only: [:new, :create, :edit, :update, :destroy]
  def new
    @sub = Sub.new
    @links = []
    5.times{@links << Link.new}
    render :new
  end

  def create
    begin
      ActiveRecord::Base.transaction do
        @sub = Sub.new(params[:sub])

        @links = params[:link].map do |_, link|
          next if link.values.all?{|val| val.empty?}
          p link
          Link.new(link)
        end
        @links.compact!
        @sub.mod_id = current_user.id
        @sub.save!
        @links.each do |link|
          link.user_id = current_user.id
          link.sub_id = @sub.id
          link.save!
        end
      end
    rescue
      p @sub.errors
      @links.each{|link| p link.errors}
      flash[:message] = "You did something wrong."
      render :new
    else
      redirect_to sub_url(@sub)
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  def index
    @subs = Sub.all
  end

  def edit
    @sub = Sub.find(params[:id])
    @links = @sub.links
    unless current_user == @sub.mod
      flash[message] == "You aren't the moderator here"
      redirect_to sub_url(@sub)
    else
      render :edit
    end
  end

  def update
    @sub = Sub.find(params[:id])
    unless current_user == @sub.mod
      flash[message] == "You aren't the moderator here"
      redirect_to sub_url(@sub)
    else
      begin
        ActiveRecord::Base.transaction do
          raise unless @sub.update_attributes(params[:sub])
            if params[:remove]
              if params[:remove][:links]
              params[:remove][:links].each do |id|
                Link.find(id).destroy
              end
            end
          end
        end
      rescue
        flash[:message] = "You did something wrong."
        redirect_to sub_url(@sub)
      else
        redirect_to sub_url(@sub)
      end
    end
  end
end
