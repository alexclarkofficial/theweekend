class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :show]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      sign_in @user
  	  flash[:success] = "Welcome to The Weekend!"
      redirect_to @user
    else
  	  render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Handle a successful update.
    else
      render 'edit'
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters

  def signed_in_user
    redirect_to root_path, notice: "Please sign in." unless signed_in?
  end


  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
