class UsersController < ApplicationController
   before_action :require_login, except: [:new, :create]
   before_action :require_correct_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
  	@user = User.new() 

  end

  def create 
  	@user = User.create(user_params)
  	puts @user.errors.full_messages
  	if @user.errors.count == 0
 			flash[:notice] ="You have succesfull loged in"
 			session[:user_id] = @user.id 
      redirect_to @user
 	else 
 		flash[:error] = @user.errors.full_messages
 		redirect_to '/users/new'
 	end

  end 

  def edit 
  	@user = User.find(params[:id])

  end 

  def update 
  
  	@user = User.find(params[:id])
	@user.update_attributes(user_params)
		p @user
		p @user.errors.full_messages
		redirect_to @user 
  end 

  def show 
 	@user = User.find(params[:id])
  @secret = Secret.new()
  end 

  def destroy
  	@user = User.find(params[:id]).destroy
    session['user_id'] = false
  	redirect_to '/sessions/new'
  end 

  private 
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end
