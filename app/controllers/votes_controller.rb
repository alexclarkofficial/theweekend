class VotesController < ApplicationController
  before_action :signed_in_user

  def create
    @weekend = Weekend.find(params[:vote][:weekend_id])
    current_user.vote!(@weekend)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def destroy
    @weekend = Vote.find(params[:id]).weekend
    current_user.unvote!(@weekend)
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
end