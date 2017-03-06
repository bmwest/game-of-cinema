class TheatersController < ApplicationController

  def index
    @theaters = Theater.all
  end

  def show
  end

  def new
  end

  def create
  end

  def update
  end

  def delete
  end

  private

  def theater_params
  end

end
