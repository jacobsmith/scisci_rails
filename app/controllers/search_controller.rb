class SearchController < ApplicationController

  def users
    @project = Project.find(params[:project_id])
    @users = User.where("username like ?", "%#{params[:query]}%")
  end

end
