class TagsController < ApplicationController
  def show
    project_crumb
    @tags = Tag.all.where(project_id: params[:project_id], name: params[:name]) 
  end
end