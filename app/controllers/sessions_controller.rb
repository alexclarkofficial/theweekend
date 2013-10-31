class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or user
    else
      flash[:error] = 'Please enter a valid username or email'
      redirect_to root_path
    end
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end

end