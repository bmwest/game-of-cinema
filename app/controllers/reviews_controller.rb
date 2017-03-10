class ReviewsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

  def create
    @theater = Theater.find(params[:theater_id])
    @user = current_user
    @review = Review.new(review_params)
    @review.theater = @theater
    @review.user = @user
    @rating_start = 0

    if @review.save
      flash[:notice] = "Review added successfully"
      redirect_to theater_path(@theater)
    else
      flash[:notice] = @review.errors.full_messages
      @creator = @theater.user
      @reviews = @theater.reviews
      @review = Review.new
      render "theaters/show"
    end
  end

  def edit
    @theater = Theater.find(params[:theater_id])
    @review = Review.find(params[:id])
  end

  def update
    @theater = Theater.find(params[:theater_id])
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to @theater, notice: 'Review was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @theater = Theater.find(params[:theater_id])
    @review = Review.find_by(user: current_user, theater: @theater)
    @review.destroy
    redirect_to theater_path(@theater), notice: 'Review was successfully Deleted.'
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end

  def authorize_user
    if !user_signed_in? || current_user.admin?
      flash[:notice] = "Please log in to use this feature"
      redirect_to new_user_session_path
    end
  end
end
