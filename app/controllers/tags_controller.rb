class TagsController < ApplicationController
  include ApplicationHelper

  before_filter :authenticate_user!
  #before_filter :authorize!(params[:project_id])

  def show
    authorize!(params[:project_id])
      @tags = Tag.all.where(project_id: params[:project_id], name: params[:name])
      @tag = @tags.first
  end

  def index
    authorize!(params[:project_id])
      @tags = Tag.all.where(project_id: params[:project_id])
      @project = Project.find(params[:project_id])
  end

  def destroy_all
    authorize!(params[:project_id])
    all_tags = all_project_tags(params)
    @tag_project = all_tags.first.project

    all_tags.each do |tag|
      tag.destroy
    end

    redirect_to project_path(@tag_project), notice: "Tag successfully deleted."
  end

  def destroy_one
    # need to implement function to destroy individual tag on a note
  end

  def rename
    authorize!(params[:project_id])
    all_tags = all_project_tags(params)
    all_tags.each do |tag|
      tag.name = params[:new_name]
      tag.save
    end
  end

  def all_project_tags(params)
    authorize!(params[:project_id])
    tag_name = params[:name]
    tags = Tag.all.where(project_id: params[:project_id], name: params[:name])
  end

  private

  def authorize!(project_id)
    if current_user.can_read? Project.find(project_id)
    else
      redirect_to project_path(project_id), notice: "You are not authorized to visit that page."
    end
  end
end
