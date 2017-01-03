class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  before_action :set_project, only: [
    :show,
    :edit,
    :update,
    :destroy,
    :add_collaborator,
    :new_thesis,
    :create_thesis,
    :change_active_state,
    :edit_thesis
  ]

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
    respond_to do |format|
      format.html
      format.xls
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    authorize_user!
    @presenter = ProjectPresenter.new(@project)
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

    if @project.save
      redirect_to new_thesis_path( @project ), notice: 'Project was successfully created.'
    else
      render action: 'new', errors: @project.errors
    end
  end

  def new_thesis
  end

  def edit_thesis
    render :new_thesis
  end

  def create_thesis
    @project.thesis = params[:thesis]
    @project.save
    redirect_to projects_path(@project), notice: "Your thesis has been created. You're ready to start your research!"
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    authorize_user!

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(@project), notice: 'Project was successfully updated.' }
        format.json { render json: @project }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors }
      end
    end

  end

  def change_active_state
    desired_state = params[:inactive] == "true" ? :inactive : :active

    if desired_state == :active && current_user.can_create_new_projects?
      @project.active = true
      @project.save
      redirect_to projects_path, notice: "Successfully marked '#{@project.name}' as active."
    elsif desired_state == :active && !current_user.can_create_new_projects?
      redirect_to projects_path, notice: "Sorry, you don't have room for another active project. Please upgrade your account or mark one of your old projects as inactive."
    elsif desired_state == :inactive
      @project.active = false
      @project.save
      redirect_to projects_path, notice: "Successfully marked '#{@project.name}' as inactive."
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
      @project = params[:project_id] ? Project.find(params[:project_id].to_i) : Project.find(params[:id])
      @class_project = @project.section_id
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :thesis, :due_date)
    end

    def authorize_user!
      if current_user.can_read? @project
      else
        redirect_to projects_path, notice: "You are not authorized to visit that page."
      end
    end
end
