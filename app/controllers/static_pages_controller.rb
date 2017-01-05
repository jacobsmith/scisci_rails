class StaticPagesController < ApplicationController
  def home
  end

  def example_theses
  end

  def pricing
    # this is a bad hack because I want to let devise handle registration,
    # so I just add a parameter to the URL after successful account creation
    # and take them to the logged-in version of the sales page
    if params[:sign_up_successful] == "true"
      flash[:notice] = "Thanks for signing up, #{current_user.username}! You can now purchase a plan."
      redirect_to view_plans_path
    end
  end

  def about
  end
end
