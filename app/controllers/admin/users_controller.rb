class Admin::UsersController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    if @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully destroyed.'
    end
  end
end
