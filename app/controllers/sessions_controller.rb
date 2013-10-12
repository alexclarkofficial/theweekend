class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by(name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash[:error] = 'Please enter a valid username or email' # Not quite right!
      redirect_to root_path
    end
  end

  def destroy
  	sign_out
  	redirect_to root_path
  end

end
