class FeedsController < ApplicationController
  
  def home
    @week_items = Hash.new
    Week.find_each do |week|
      @week_items[week] = feed_weekends_for_user.from_week(week).paginate(page: params[:page])
    end
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