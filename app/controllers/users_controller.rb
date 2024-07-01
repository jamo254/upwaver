class UsersController < ApplicationController
  def dashboard
  end

  # Display user
  def show
    @user = User.find(params[:id])
  end

  # User parameters
  private
  def  current_user_params
    params.require(:user).permit(:from, :about, :status, :language, :avatar)
  end
end
