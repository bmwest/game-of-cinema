class Api::V1::TheatersController < ApplicationController
  def index
    render json: Theater.all, include: ['user', 'reviews']
  end
end
