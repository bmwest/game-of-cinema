class HomeController < ApplicationController
  def index
    @theaters = Theater.all
    @most_reviewed = Theater.all.sort { |theater| theater.reviews.count }.reverse[0..4]
  end
end
