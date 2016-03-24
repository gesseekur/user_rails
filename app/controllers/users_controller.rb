class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def show
  	@user = User.find(params[:id])
    @secrets = User.find(params[:id]).secrets
  end

  def new
  end

  def create 
  	u = User.new(user_params)
    session[:user_id] = u.id
  	if u.save
  		redirect_to "/users/#{u.id}"
  	else 
  		flash[:errors] = u.errors.full_messages
  		redirect_to :back
  	end
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update 
  	u = User.find(params[:id])
  	if u.update(user_params) 
  		redirect_to "/users/#{u.id}"
  	else 
  		flash[:errors] = u.errors.full_messages
  		redirect_to :back
  	end
  end 

  def destroy
  	u = User.find(params[:id])
  	u.destroy
  	session[:user_id] = nil
  	redirect_to '/sessions/new'
  end

  private
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
