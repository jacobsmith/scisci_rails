class NotesController < ApplicationController

  before_filter :authenticate_user!

  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  # GET /notes.json
  def index
    authorize_user! Source.find(params[:source_id].to_i)
    @notes = Note.all
  end

  # GET /projects/:project_id/notes
  # return all notes that belong to a project
  def project_index
    authorize_user! @project = Project.find(params[:project_id].to_i)
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Source.find(params[:source_id]).notes.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @tags = params[:note][:existing_tags]
    params[:note][:existing_tags] = '' 

    @note = Source.find(params[:source_id]).notes.new(note_params)
    respond_to do |format|
      if @note.save
        @note.tags = @tags
        @note.save
        format.html { redirect_to source_notes_path(@note.source), notice: 'Note was successfully created.' }
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
    @tags = params[:note][:existing_tags]
    params[:note][:existing_tags] = ''

    respond_to do |format|
      if @note.update(note_params)
        @note.tags = @tags

        format.html { redirect_to note_path( @note ), notice: 'Note was successfully updated.' }
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
    source = @note.source
    @note.destroy
    respond_to do |format|
      format.html { redirect_to source_notes_path(source) }
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
    
    def authorize_user!( arg = @note )
      if current_user.can_read? arg 
      else
        redirect_to sources_path, notice: "You are not authorized to visit that page."
      end
    end
end
