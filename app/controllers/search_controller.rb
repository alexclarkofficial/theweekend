class SearchController < ApplicationController

  def index
    @users = User.search(name: params[:q]).paginate(page: params[:page])
  end
end
