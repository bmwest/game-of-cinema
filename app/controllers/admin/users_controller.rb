class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @ghost = User.find_by(first_name: "Ghost")
    @user_theaters = @user.theaters
    @user_reviews = @user.reviews

    @user_theaters.each do |theater|
      theater.user = @ghost
      theater.save
    end

    @user_reviews.each do |review|
      review.user = @ghost
      review.save
    end

    @user.destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully destroyed.'
    end
  end
end
