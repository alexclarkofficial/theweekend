class FeedsController < ApplicationController
  
  def home
    @week = params[:week] ? Week.find(params[:week]) : Week.first
    @weekends = feed_weekends_for_user.from_week(@week).paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def feed_weekends_for_user
    Weekend.from_users_followed_by(current_user)
  end
end
