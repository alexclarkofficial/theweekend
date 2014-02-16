class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = find_user_by_name || find_user_by_email
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

  private

  def find_user_by_name
    User.where("LOWER(name) = LOWER(?)", params[:session][:name_or_email].downcase).first
  end

  def find_user_by_email
    User.where("LOWER(email) = LOWER(?)", params[:session][:name_or_email].downcase).first
  end
end