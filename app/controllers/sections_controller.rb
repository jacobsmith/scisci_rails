class SectionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :load_section, only: [:show, :create_section_project]

  def index
    @sections = current_user.taught_sections
    return unauthorized! unless @sections.any?

    # not sure how to only require "sections" sometimes in params,
    # so this is a hack to only use strong params if params["sections"] is set

    filter = FilterViewableProjects.perform(
      section_id: params.dig(:section, :id),
      section_project_id: params.dig(:section_project, :id),
      current_user: current_user
    )

    @filtered_sections = filter.filtered_sections
    @projects = filter.projects
    @students = filter.students

    @section_projects = []
    @filtered_sections.each do |section|
      section.section_projects.each do |section_project|
        @section_projects << [section_project.project_name, section_project.id]
      end
    end
  end

  def show
    unauthorized! unless current_user.taught_sections.include?(@section)
  end

  def create_section_project
    @sections = current_user.taught_sections
    return unauthorized! unless @sections.include?(@section)

    section_project = SectionProject.new(section: @section, project_name: params[:project_name])

    if section_project.save
      @section.students.each do |student|
        student.projects.create(name: section_project.project_name, section_project_id: section_project.id)
      end

      flash[:success] = "Successfully created the class project: #{params[:project_name]}"
      redirect_to sections_path(section: { id: @section.id }, section_project: { id: section_project.id })
    else
      flash[:warning] = "Oops! Something went wrong. Please try again."
      redirect_to :back
    end
  end

  private

  def load_section
    @section = Section.find(params[:id])
  end

  def filterable_params
    params.require(:section).permit(
      :id
    )
  end
end
