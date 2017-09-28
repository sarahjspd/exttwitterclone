class LikesController < ApplicationController

	def create
		@twee = Tweet.find(params[:tweet_id])
		@lik = Like.new
		@lik.user_id = current_user.id
		@lik.tweet_id = @twee.id

		if @lik.save
			# redirect_to tweets_path
			respond_to do |format|
			    format.html { redirect_to tweets_path }
			    format.js { render :likeunlikebutton }
  			end
		end
	end

	def destroy
		@twee = Tweet.find(params[:tweet_id])
		@lik = Like.find(params[:id])
		if @lik.destroy
			respond_to do |format|
			    format.js { render :likeunlikebutton }
  			end
		end
	end

end