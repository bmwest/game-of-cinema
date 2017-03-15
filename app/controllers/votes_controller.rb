class VotesController < ApplicationController
  before_action :authorize_user, :set_params

  def create
    @review = Review.find(params[:review_id])
    @value = params[:value]
    @vote = Vote.where(user: current_user, review: @review).first

    if @vote.nil?
      @vote = Vote.new(review: @review, value: @value)
      @vote.user = current_user
    elsif @vote.value == params[:value]
      @vote.value = nil
    else
      @vote.value = params[:value]
    end

    if @vote.save
      @review.update_attributes(upvotes: Vote.where(review: @review, value: "upvote").count)
      @review.update_attributes(downvotes: Vote.where(review: @review, value: "downvote").count)
      @review.save
      respond_to do |format|
        format.json { render json: { upvotes: @review.upvotes, downvotes: @review.downvotes, review_id: @review.id } }
      end
    else
      flash[:error] = 'Something went wrong with your request.'
      redirect_to :back
    end
  end

  private

  def set_params
    @review = Review.find(params[:review_id])
    @value = params[:value]
  end

  def authorize_user
    unless user_signed_in? || (current_user && current_user.admin?)
      flash[:notice] = "Please log in to use this feature"
      redirect_to new_user_session_path
    end
  end
end
