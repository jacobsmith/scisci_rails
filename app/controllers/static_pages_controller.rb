class StaticPagesController < ApplicationController
  def form
    puts params.inspect

    @form_id = params["form-id"]
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'static_pages/static_pages_form_response' }
    end
  end

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

  def for_schools
  end

  def for_schools_form
    Rails.logger.info("SCHOOLS FORM ADDED!")
    Rails.logger.info(params.inspect)

    SiteAdminMailer.custom("Schools form submitted", "#{params.inspect}").deliver!

    @form_id = params["form-id"]
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'static_pages/for_schools_form' }
    end
  end

  def upcoming_features
  end

end
