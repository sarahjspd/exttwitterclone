class UsersController < ApplicationController
	def show

		@user = User.find(params[:id])
		@leadercount = @user.leaders.count
		@followercount = @user.followers.count
	end
end