class NotesController < ApplicationController
  include BreadcrumbHelper
  include RoutesHelper
  before_filter :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    project_crumb
    source_crumb
    @notes = Note.all
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    project_crumb
    source_crumb
    note_crumb
  end

  # GET /notes/new
  def new
    project_crumb
    source_crumb
    @note = Source.find(params[:source_id]).notes.new
  end

  # GET /notes/1/edit
  def edit
    project_crumb
    source_crumb
  end

  # POST /notes
  # POST /notes.json
  def create
    @tags = params[:note][:tags]
    params[:note][:tags] = '' 

    @note = Source.find(params[:source_id]).notes.new(note_params)
    respond_to do |format|
      if @note.save
        @note.tags = @tags
        format.html { redirect_to project_source_notes_path, notice: 'Note was successfully created.' }
        format.json { render action: 'show', status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    @tags = params[:note][:tags]
    params[:note][:tags] = ''

    respond_to do |format|
      if @note.update(note_params)
        @note.tags = @tags

        format.html { redirect_to project_source_notes_path(@note.source.project, @note.source), notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:quote, :comments, :tags)
    end

#    def project_crumb
#      project = Project.find(params[:project_id]) || Project.find(params[:id])
#      add_crumb project.name, project_path(project)
#    end

#   def source_crumb
#      source = Source.find(params[:source_id]) || Source.find(params[:id])
#      add_crumb source.title, project_source_path(source.project, source)
#    end
#
#    def note_crumb
#      quote_split2 = @note.quote.split(" ")[0..8].join(" ") + "..."
#      quote_split = first_n_words(@note.quote, 8)
#      add_crumb quote_split 
#    end
end
