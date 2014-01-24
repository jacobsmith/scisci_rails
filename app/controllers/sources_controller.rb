class SourcesController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_source, only: [:show, :edit, :update, :destroy]

  # GET /sources
  # GET /sources.json
  def index
    @project = Project.first(params[:project_id])
    authorize_user! @project
    add_crumb @project.name, project_path(@project)
  end

  # GET /sources/1
  # GET /sources/1.json
  def show
    authorize_user!
    add_crumb @source.project.name, project_path(@source.project)
  end

  # GET /sources/new
  def new
    @source = Source.new
  end

  # GET /sources/1/edit
  def edit
    authorize_user!
  end

  # POST /sources
  # POST /sources.json
  def create
    @source = Project.find(params[:project_id]).sources.new(source_params)

    respond_to do |format|
      if @source.save
        format.html { redirect_to project_sources_path(@source.project), notice: 'Source was successfully created.' }
        format.json { render action: 'show', status: :created, location: @source }
      else
        format.html { render action: 'new' }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sources/1
  # PATCH/PUT /sources/1.json
  def update
    authorize_user!
    respond_to do |format|
      if @source.update(source_params)
        format.html { redirect_to project_sources_path(@source.project), notice: 'Source was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sources/1
  # DELETE /sources/1.json
  def destroy
    authorize_user!
    respond_to do |format|
      format.html { redirect_to sources_path(@source) }
      format.json { head :no_content }
      @source.destroy
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source
      @source = Source.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_params
      params.require(:source).permit(:title, :author, :url, :comments)
    end

    def authorize_user! (arg = @source)
      if current_user.can_read? arg 
      else
        redirect_to projects_path, notice: "You are not authorized to visit that page."
      end
    end
end
