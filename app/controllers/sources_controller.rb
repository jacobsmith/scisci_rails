class SourcesController < ApplicationController
  include BreadcrumbHelper
  include RoutesHelper
  before_filter :authenticate_user!
  before_action :set_source, only: [:show, :edit, :update, :destroy]

  # GET /sources
  # GET /sources.json
  def index
    project_crumb
    @sources = Source.all
  end

  # GET /sources/1
  # GET /sources/1.json
  def show
    project_crumb
    source_crumb
  end

  # GET /sources/new
  def new
    project_crumb
    @source = Source.new
  end

  # GET /sources/1/edit
  def edit
    project_crumb
    source_crumb
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

#    def project_crumb
#      project = Project.find(params[:project_id]) || Project.find(params[:id])
#      add_crumb project.name, project_path(project)
#    end
    
#    def source_crumb
#      ## ugly hack to account for when id is just for source--overridden if source_id exists
#      source = Source.find(params[:id]) if params[:id]
#      source = Source.find(params[:source_id]) if params[:source_id]
#      title = first_n_words( source.title, 8 )
#      add_crumb(title, source_path(source))
#    end
end
