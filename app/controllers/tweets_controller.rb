class TweetsController < ApplicationController

  	# before_action :find_tweet, only: [:edit, :show, :update, :destroy]

  	def find_tweet
		@twee = Tweet.find(params[:id])
  	end

	def index
		@user = current_user
		@newtwee = Tweet.new
		@twee = Tweet.all
		@lik = Like.all
		@user = current_user
		@lid = (@user.leaders.pluck(:leader_id) << @user.id)
		@leadertweet = Tweet.where(user_id: @lid)

		@tweecount = @user.tweets.count
		@leadercount = @user.leaders.count
		@followercount = @user.followers.count
		@allprofile = User.all
		@newtofollow = @allprofile.where.not(id: @user.id)

		@lik = Like.all
		@culikedtweets = @lik.where(user_id: current_user.id).pluck(:tweet_id)
		@userswholikedthesametweets = @lik.where(tweet_id: @culikedtweets).pluck(:user_id)
		@tweetsrec = Tweet.where(user_id: @userswholikedthesametweets)

		@followers = Following.where(follower_id: current_user.id)
		@leaders = @followers.pluck(:leader_id)
		@tweetsfollowrec = Tweet.where(user_id: @leaders)


		# @tweelike = Tweet.find(params[:id])
		# @likebutton = Like.find_by(user_id: current_user.id, tweet_id: @twee.id)
		# @likcount = Like.where(tweet_id: @twee.id).count
	end

	def new
		@twee = Tweet.new
	end

	def create
		# post_params = params[:tweet].permit(:post)
		@twee = Tweet.new(post_params)
		@twee.user_id = current_user.id
		
		if @twee.save
			flash[:success] = "Tweet successfully created"
			respond_to do |format|
					format.html {
			redirect_to tweets_path }
			format.js { render :tweet }
			end
		else
			flash.now[:notice] = "Tweet not successfully created"
			render "new"
		end
	end

	def show
		@twee = Tweet.find(params[:id])
		@repli = Reply.new
		
		@lik = Like.find_by(user_id: current_user.id, tweet_id: @twee.id)
		@likcount = Like.where(tweet_id: @twee.id).count
	end

	def edit
		@twee = Tweet.find(params[:id])
	end

	def update
		# post_params = params.require(:tweet).permit(:post)
		@twee = Tweet.find(params[:id])
		if @twee.update(post_params)
			flash[:notice] = "Tweet successfully updated"
			redirect_to tweets_path
		else
			flash.now[:notice] = "Tweet not successfully updated"
			render "edit"
		end

	end

	def destroy
		@twee = Tweet.find(params[:id])
		if @twee.destroy
			flash[:notice] = "Tweet successfully destroyed"
			redirect_to tweets_path
		else
			flash.now[:notice] = "Tweet not successfully destroyed"
			redirect_to tweets_path
		end
	end

	private
	def post_params
		params.require(:tweet).permit(:post)
	end
end