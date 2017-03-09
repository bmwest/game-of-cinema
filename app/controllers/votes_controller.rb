class VotesController < ApplicationController
  before_action :authorize_user

  def create
    review = Review.find(params[:review_id])
    theater = review.theater
    user = current_user
    vote = Vote.where(user: current_user, review: review)

    if vote.count > 0
      vote.destroy_all
    end

    if params[:value] == "upvote"
      upvote(review, user)
    elsif params[:value] == "downvote"
      downvote(review, user)
    end
    redirect_to theater_path(theater)
  end

  def upvote(review, user)
    Vote.create(review: review, user: user, value: "upvote")
  end

  def downvote(review, user)
    Vote.create(review: review, user: user, value: "downvote")
  end

  private

  def theater_params
    params.require(:vote).permit(:value)
  end

  def authorize_user
    if !user_signed_in? || current_user.admin?
      flash[:notice] = "Please log in to use this feature"
      redirect_to new_user_session_path
    end
  end
end
