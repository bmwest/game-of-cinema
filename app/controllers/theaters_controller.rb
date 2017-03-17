class TheatersController < ApplicationController
  before_action :authorize_user, except: [:index, :show]

  def index
    @theaters = Theater.all

    if params[:search]
      @theaters = Theater.search(params[:search].capitalize)
    end
  end

  def show
    @theater = Theater.find(params[:id])
    @creator = @theater.user
    @reviews = @theater.reviews.sort_by(&:created_at)
    @review = Review.new
    @rating_start = 0
  end

  def new
    @theater = Theater.new
  end

  def edit
    @theater = Theater.find(params[:id])
  end

  def create
    @theater = Theater.new(theater_params)

    @theater.user = current_user

    if @theater.save
      flash[:notice] = "Theater added successfully"
      ReviewMailer.send_created_theater_email(@theater.user).deliver
      redirect_to theater_path(@theater)
    else
      flash[:notice] = @theater.errors.full_messages
      render :new
    end
  end

  def update
    @theater = Theater.find(params[:id])

    if @theater.update(theater_params)
      redirect_to @theater, notice: 'Theater was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @theater = Theater.find(params[:id])
    @theater.destroy
    redirect_to theaters_url, notice: 'Theater was successfully destroyed.'
  end

  private

  def theater_params
    params.require(:theater).permit(:name, :address, :city, :state, :zip, :image, :remove_image)
  end

  def authorize_user
    unless user_signed_in? || (current_user && current_user.admin?)
      flash[:notice] = "Please log in to use this feature"
      redirect_to new_user_session_path
    end
  end
end
