require 'pry'
class SectionsController < ApplicationController
  include BreadcrumbsHelper
  before_filter :authenticate_user!
  before_action :authorize_user!, except: [:index, :show]
  before_action :set_section, except: [:index, :new]

  # GET /sections
  # GET /sections.json
  def index
    @sections = []
    if current_user.is_a? Teacher
      @sections << Section.where(teacher_id: current_user.id)
    else
      Student_Section_Relation.where(student_id: current_user.id).each do |section|
        @sections << section
      end
    end
    @sections.flatten!
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    @projects = Project.where(section_id: @section.id)
  end

  # GET /sections/1/projects/14
  def section_project
    @projects = Project.where(section_id: params[:section_id], section_project_id: params[:project_id])
  end

  def create_section_project
    # had to do some funky form stuff to get this to work...should re-look at
    @section.deploy_project(params[:section][:project_name_to_deploy]) 
    redirect_to section_path(params[:section])
  end
######
  # GET /sections/new
  def new
    # Create new section (class period)
    @section = Section.new(teacher_id: current_user.id)
  end

  # GET /projects/1/edit
  def edit
    authorize_user!
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path( @project ), notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    authorize_user!
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path( @project.user, @project ), notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    if current_user == @project.user 
      collabs = Collaborator.all.where(project_id: @project.id)
      collabs.each { |collab| Collaborator.destroy(collab) }
      @project.destroy
    else
      flash[:alert] = "Only the owner of a project can delete it."
    end

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def add_collaborator
    if @project.user == current_user
      @project.add_collaborator(User.find(params[:user_id]))
      @project.save
      redirect_to @project
    else
      flash[:alert] = "Only the project owner can add collaborators."
      redirect_to @project
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      # if params[:id], find by that, else, find by params[:section_id]
      @section = params[:id] ? Section.find(params[:id].to_i) : Section.find(params[:section_id].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
    end

    def authorize_user!
      set_section
      if current_user.id == @section.teacher_id.to_i ##|| Student_Section_Relation.(section_id: @section.id, student_id: current_user.id)
      else
        redirect_to projects_path, notice: "You are not authorized to visit that page."
      end
    end
end
