class SessionsController < ApplicationController
  def new
   
  	@session = User.new 
  end
  def create  
	@user = User.find_by(email:params[:user][:email])
	
	
		if @user && @user.authenticate(params[:user][:password])
			@id = @user.id 
			redirect_to user_path(@id)
			session[:user_id]= @id 

		else 
		flash[:error] = 'Invalid'
		redirect_to '/sessions/new'
		end 
  end 
   
   def destroy
   	session[:user_id] = nil 
   	redirect_to '/sessions/new'
   end 
  

  private 
  def sessions_params 
  	params.require(:session).permit(:email, :password)
  end 

end
