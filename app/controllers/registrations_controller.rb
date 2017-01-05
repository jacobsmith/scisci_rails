class RegistrationsController < Devise::RegistrationsController
  respond_to :html, :js

  ##
  protected

  def after_sign_up_path_for(resource)
    '/projects'
  end
end
