class UsersController < ApplicationController
  def dashboard
  end

  
  private
  def  current_user_params
    params.require(:user).permit(:from, :about, :status, :language, :avatar)
  end
end
