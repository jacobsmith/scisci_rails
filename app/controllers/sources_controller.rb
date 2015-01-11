class SourcesController < ApplicationController
  include SourcesHelper

  before_filter :authenticate_user!
  before_action :set_source, only: [:show, :edit, :update, :destroy]

  # GET /sources
  # GET /sources.json
  def index
    @project = Project.find(params[:project_id].to_i)
    authorize_user!( @project )
  end

  # GET /sources/1
  # GET /sources/1.json
  def show
    authorize_user!
  end

  # GET /sources/new
  def new
    @source = Source.new(project: Project.find(params[:project_id])) 
  end

  # GET /sources/1/edit
  def edit
    authorize_user!
  end

  # POST /sources
  # POST /sources.json
  def create
    params = clean_authors

    @source = Project.find(params[:project_id]).sources.new(source_params)
    @source.user_id = current_user.id

    @source.update_image

    respond_to do |format|
      if @source.save
        format.html { redirect_to source_path(@source), notice: 'Source was successfully created.' }
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
    params = clean_authors

    @source.update_image

    respond_to do |format|
      if @source.update(source_params)
        format.html { redirect_to source_path(@source), notice: 'Source was successfully updated.' }
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
    # all_allowed_params generated in SourcesHelper
    def source_params
      params.require(:source).permit(all_allowed_params)
    end

    def authorize_user! (arg = @source)
      if current_user.can_read? arg
      else
        redirect_to projects_path, notice: "You are not authorized to visit that page."
      end
    end

    def clean_authors
      authors = []
      1.upto(10) do |i|
        author = []
        author << params["source"]["authorFirst##{i}"] if params["source"]["authorFirst##{i}"] != nil
        author << params["source"]["authorLast##{i}"] if params["source"]["authorLast##{i}"] != nil
        authors << author.join(" ") if author != []

        params["source"].delete "authorFirst##{i}"
        params["source"].delete "authorLast##{i}"
      end
    params["source"]["authors"] = authors.join(", ")
    params
  end
end
