class LikesController < ApplicationController
before_action :require_login, only: [:create, :destroy]
	

	def create 
		p params[:secret_id] 
		 
		@like = Like.create(secret: Secret.find(params[:secret_id]), user: current_user)
		redirect_to '/secrets'
	end

	def destroy 
	@user = current_user
	 @like = Like.where("secret_id = ? AND user_id = ?", Secret.find(params[:id]) , current_user)
	
	@like[0].destroy  
	redirect_to @user

	end 


end
