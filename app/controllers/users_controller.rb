class UsersController < ApplicationController
  include ApplicationHelper

  before_filter :authenticate_user!

  def edit
    authorize_user!
    @user = current_user
  end

  def update
    authorize_user!
    if current_user.update(user_params)
      redirect_to projects_path, notice: "Information updated successfully."
    else
      redirect_to edit_user_path, notice: "Your information was not saved successfully. Please try again."
    end
  end

  private

  def authorize_user!
    if current_user == User.find(params[:id])
    else
      redirect_to root_path, notice: "You are not authorized to visit that page."
    end
  end

  def user_params
   params.require(:user).permit(:email, :searchable)
  end

end
