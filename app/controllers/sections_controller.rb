require 'pry'
class SectionsController < ApplicationController
  include BreadcrumbsHelper
  before_filter :authenticate_user!
  before_action :authorize_user!, except: [:index, :show, :new, :section_project, :create]
  before_action :set_section, except: [:index, :new, :create]

  # GET /sections
  # GET /sections.json
  def index
    @sections = []
    if current_user.is_a? Teacher
      @sections << Section.where(teacher_id: current_user.id)
    else
      Student_Section_Relation.where(student_id: current_user.id).each do |section|
        @sections << Section.find(section.section_id)
      end
    end
    @sections.flatten!
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    @projects = @section.all_projects(current_user)
  end

  # GET /sections/1/projects/14
  def section_project
    if current_user.is_a? Student
      @projects = Project.where(section_id: params[:section_id], section_project_id: params[:section_project_id], user_id: current_user.id)
      @class_project = true
      render 'projects/index'
    end

    if current_user.is_a? Teacher
      @projects = Project.where(section_id: params[:section_id], section_project_id: params[:section_project_id])
      render 'class_list'
    end
  end

  def create_section_project
    # had to do some funky form stuff to get this to work...should re-look at
    @section.deploy_project(params[:section][:project_name_to_deploy]) 
    redirect_to section_path(params[:section])
  end

  # GET /sections/new
  def new
    # Create new section (class period)
    @section = Section.new(teacher_id: current_user.id) if current_user.is_a? Teacher
  end

  # GET /projects/1/edit
  def edit
    authorize_user!
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)
    @section.update_attribute :teacher_id, current_user.id if current_user.is_a? Teacher 
    @section.teacher_id = current_user.id if current_user.is_a? Teacher

    respond_to do |format|
      if @section.save and current_user.is_a? Teacher
        format.html { redirect_to section_path( @section ), notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    authorize_user!
    respond_to do |format|
      if @section.update(project_params)
        format.html { redirect_to section_path( @section ), notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    if current_user.to_i == @section.teacher_id.to_i 
      Student_Section_Relation.where(section_id: @section.id).each do |section_relation|
        section_relation.destroy 
      end
      @section.destroy
    else
      flash[:alert] = "Only the teacher may remove a class."
    end

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      # if params[:id], find by that, else, find by params[:section_id]
      @section = params[:id] ? Section.find(params[:id].to_i) : Section.find(params[:section_id].to_i)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:name)
    end

    def authorize_user!
      set_section 
      ## authorize teacher, student records are bounded by their id's naturally (handled by authentication)
      if current_user.id == @section.teacher_id.to_i #Section.find(params[:section_id]).teacher_id.to_i 
      else
        redirect_to projects_path, notice: "You are not authorized to visit that page."
      end
    end
    
end
