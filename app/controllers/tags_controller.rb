class TagsController < ApplicationController
  include ApplicationHelper
  include BreadcrumbsHelper

  before_filter :authenticate_user!

  def show
    project_crumb
    if current_user.can_read? Project.find(params[:project_id])
      @tags = Tag.all.where(project_id: params[:project_id], name: params[:name])
      @tag =  @tags.first
    end
  end

  def index
    if current_user.can_read? Project.find(params[:project_id])
      @tags = Tag.all.where(project_id: params[:project_id])
      @project = Project.find(params[:project_id])
    end
  end

end
