class SearchController < ApplicationController

  def index
    @users = User.search(name: params[:q])
  end

end