class SessionsController < ApplicationController

	skip_before_action :logged_in?


	def new
		render '/sessions/new'
	end

	def create
		@user = User.find_by(email: params[:email])

		if @user && @user.authenticate(params[:password])
			session[:user_id] = @user.id
			redirect_to '/'
		else
			flash[:notice] = "Please Try Again"
			render '/sessions/new'
		end

	end

	def destroy
		session.clear
		IntercomRails::ShutdownHelper::intercom_shutdown_helper(cookies)
		binding.pry
		redirect_to '/'
	end

	def shutdown_intercom
	end

end
