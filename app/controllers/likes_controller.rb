class LikesController < ApplicationController
	before_action :require_login  
	before_action :require_correct_user_for_likes, only: [:destroy]

	def create
		like = Like.new(user:current_user, secret:Secret.find(params[:secret_id]))
		if like.save
			redirect_to "/secrets"
		else 
			flash[:errors] = like.errors.full_messages
		end
	end 

	def destroy 
		like = Like.find(params[:id]) 
		if like.destroy
			redirect_to '/secrets'
		else 
			flash[:errors] = like.errors.full_messages
		end
	end 


end 
