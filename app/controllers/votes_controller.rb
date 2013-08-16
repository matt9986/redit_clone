class VotesController < ApplicationController
	def create
		if @vote = Vote.find_by_user_id_and_link_id(current_user.id,
																							 params[:link_id])
			@vote.update_attributes(value: params[:value])
		else
			@vote = Vote.new(user_id: current_user.id, link_id: params[:link_id],
											 value: params[:value])
			@vote.save
		end
		redirect_to link_url(params[:link_id])
	end
end
