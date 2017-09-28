class RepliesController < ApplicationController

	def create
		@twee = Tweet.find(params[:tweet_id])
		repli_params = params.require(:reply).permit(:post)
		@repli = @twee.replies.build(repli_params)
		@repli.user_id = current_user.id
		@repli.tweet_id = @twee.id
		if @repli.save
			flash[:notice] = "Replied Successfully"
			redirect_to tweet_path(id: @twee.id)
		else
			flash.now[:notice] = "Unsuccessful, please check your input"
			@twee = Tweet.find(params[:tweet_id])
			render 'tweets/show'
		end
	end

	def edit
		@twee = Tweet.find(params[:tweet_id])
		@repli = Reply.find(params[:id])
	end

	def update
		@twee = Tweet.find(params[:tweet_id])
		@repli = Reply.find(params[:id])
		repli_params = params.require(:reply).permit(:post)
		if @repli.update(repli_params)
			flash[:notice] = "Reply Updated Successfully"
			redirect_to tweet_path(id: @twee.id)
		else
			flash.now[:notice] = "Unsuccessful Reply Edit, please check your input"
			render :edit
		end
	end

	def destroy
		@twee = Tweet.find(params[:tweet_id])
		@repli = Reply.find(params[:id])
		if @repli.destroy
			flash[:notice] = "Successfully Destroyed"
			redirect_to tweet_path(id: @twee.id)
		end
	end
end