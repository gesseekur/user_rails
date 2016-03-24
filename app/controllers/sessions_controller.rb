class SessionsController < ApplicationController
  def index
  end

  def create
  	user = User.find_by(email: params[:email])
  	if user && user.authenticate(params[:password]) 
  		session[:user_id] = user.id 
  		redirect_to "/users/#{user.id}"
  	else 
  		flash[:msg] = 'Invalid user/password combination'
  		redirect_to :back
  	end
  end 

  def destroy
  	session[:user_id] = nil
  	redirect_to ('/sessions/new')
  end 
end
