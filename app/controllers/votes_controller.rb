# class VotesController < ApplicationController
# 	def create
# 		create_vote(current_user.id, params[:link_id], params[value])
# 		redirect_to link_url(params[:link_id])
# 	end

# 	def create_vote(user_id, link_id, value)
# 		if vote = Vote.find_by_user_id_and_link_id(user_id, link_id)
# 			vote.update_attributes(value: value)
# 		else
# 			vote = Vote.new(user_id: user_id, link_id: link_id, value: value)								 
# 			vote.save
# 		end
# 		vote
# 	end

# end