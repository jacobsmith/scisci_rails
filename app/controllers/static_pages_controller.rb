class StaticPagesController < ApplicationController
  def form
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
  end

  def pricing_form
    Rails.logger.info("PRICING FORM ADDED!")
    Rails.logger.info(params.inspect)

    SiteAdminMailer.custom("Pricing form submitted", "#{params.inspect}").deliver!

    @form_id = params["form-id"]
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'static_pages/for_schools_form' }
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

  def feedback_form
    SiteAdminMailer.custom("Schools form submitted", "#{params.inspect}").deliver!

    @form_id = params["form-id"]
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'static_pages/for_schools_form' }
    end

  end

  def upcoming_features
  end

  def privacy
  end

end
