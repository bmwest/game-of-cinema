class TheatersController < ApplicationController

  def index
    @theaters = Theater.all
  end

  def show
    @theater = Theater.find(params[:id])
  end

  def new
    @theater = Theater.new
  end

  def edit
    @theater = @theater = Theater.find(params[:id])
  end

  def create
    @theater = Theater.new(theater_params)
    if @theater.save
      flash[:notice] = "Theater added successfully"
      redirect_to theater_path(@theater)
    else
      flash[:notice] = @theater.errors.full_messages
      render :new
    end
  end

  def update
    @theater = @theater = Theater.find(params[:id])
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
    params.require(:theater).permit(:name, :address, :city, :state, :zip)
  end

end
