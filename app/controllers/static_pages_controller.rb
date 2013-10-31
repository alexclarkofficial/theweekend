class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @weekend = current_user.weekends.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def myweekends
  end
end