class VotesController < ApplicationController
  before_action :signed_in_user

  def create
    @weekend = Weekend.find(params[:vote][:weekend_id])
    current_user.vote!(@weekend)
    redirect_to :back
  end

  def destroy
    @weekend = Vote.find(params[:id]).weekend
    current_user.unvote!(@weekend)
    redirect_to :back
  end
  
end