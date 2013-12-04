class StaticPagesController < ApplicationController

  def home
    if signed_in?
      weeks = Week.all
      @week_items = Hash.new
      weeks.each do |week|
        feed_weekends = week.weekends.from_users_followed_by(current_user)
        feed_weekends.sort! { |x, y| y.votes.count <=> x.votes.count }
        @week_items[week] = feed_weekends.paginate(:page => params[:page])
      end
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

end