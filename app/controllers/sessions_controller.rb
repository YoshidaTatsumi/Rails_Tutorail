class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
    	log_in user
      remember user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)   #チェックボックスがオンのときに'1'になり、オフのときに'0'になります
      redirect_to user 		#user_url(user))と同じ
    else
    	flash.now[:danger] = 'Invalid email/password combination'
    	render 'new'
		end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
