require 'rails_helper'

RSpec.describe LikesController, type: :controller do 
	before do 
		@user = create_user
		@secret = @user.secrets.create(content:'Oops')
		@like = Like.create(user:@user, secret:@secret)
	end 

	describe "when not logged in" do 
		before do 
			session[:user_id] = nil
		end 

		it "cannot like a secret" do 
			post :create, id: @like 
			expect(response).to redirect_to('/sessions/new')
		end 

		it "cannot unlike a secret" do 
			delete :destroy, id: @like
			expect(response).to redirect_to('/sessions/new')
		end 
	end

	describe "when signed in as the wrong user" do 
		before do 
			@wrong_user = create_user 'julius', 'julius@lakers.com'
			session[:user_id] = @wrong_user 
			@secret = @user.secrets.create(content:'Oops')
		end 

		# it "cannot like it's own secret" do 
		# 	post :create, id: @like 
		# 	expect(response).to redirect_to("/users/#{@wrong_user.id}")
		# end

		it "cannot destroy another users" do 
			delete :destroy, id: @like
			expect(response).to redirect_to("/users/#{@wrong_user.id}")
		end
	end 
end