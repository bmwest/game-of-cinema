class SearchController < ApplicationController

  def index
    @theaters = Theater.all

    if params[:search]
      @theaters = Theater.search(params[:search].capitalize)
    end
  end
end
