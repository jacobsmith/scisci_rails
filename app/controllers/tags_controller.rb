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

  def rename_all
    authorize!(params[:project_id])

    project = params[:project_id]
    tag = params[:name]

    all_tags = all_project_tags(params)
    errors = []
    all_tags.each do |tag|
      tag.name = params[:tag][:name]
      tag.save
      errors << tag.errors if tag.errors.messages != {}
    end
    @tag_name = params[:tag][:name]

    temp_params = params

    if errors == []
      temp_params[:name] = @tag_name
      @tags = all_project_tags(temp_params)
      redirect_to project_tags_path(project, @tag_name), notice: "Tag successfully updated."
    else
      @tags = all_project_tags(temp_params)
      #TODO make the notice red (don't know what call that is)
      redirect_to project_tags_path(project, tag), notice: "You already have that tag on this note!"
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
