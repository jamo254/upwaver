class UsersController < ApplicationController
  before_action :authenticate_user!

  def dashboard
  end

  # Display user
  def show
    @user = User.find(params[:id])
  end

   #  Update user's table
  def update
    @user = current_user
    if @user.update(current_user_params)
       flash[:notice] = "Saved..."
    else
       flash[:alert] = "There is a problem..."
    end
     redirect_to dashboard_path
  end

  # User parameters
  private
  def  current_user_params
    params.require(:user).permit(:from, :about, :status, :language, :avatar)
  end
end
