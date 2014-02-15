class ProjectsController < ApplicationController
  include BreadcrumbsHelper
  before_filter :authenticate_user!

  before_action :set_project, only: [:show, :edit, :update, :destroy, :add_collaborator]

  # GET /projects
  # GET /projects.json
  def index
    #deploy concept of sections to all users
    @projects = []
    if current_user.is_a? Teacher
      @projects += Project.all.where(user_id: current_user.id, is_sectioned: false)
    else
      @projects += Project.all.where(user_id: current_user.id)
    end
    @projects += current_user.projects_as_collaborator
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    project_crumb @project 
    authorize_user!
  end

  # GET /projects/new
  def new
    @project = Project.new
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
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
    end

    def authorize_user!
      if current_user.can_read? @project
      else
        redirect_to projects_path, notice: "You are not authorized to visit that page."
      end
    end
end
