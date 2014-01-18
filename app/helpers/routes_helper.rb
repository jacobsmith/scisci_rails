module RoutesHelper
## Project shouldn't need route helpers because it is at the top of the food 
## chain as far as routing is concerned

##################
## Source paths ##
##################

  def edit_source_path(arg)
    if arg.is_a? Source 
      edit_project_source_path(arg.project, arg)
    else
      "There was an error"
    end
  end

  def sources_path(arg)
    if arg.is_a? Source 
      project_sources_path(arg.project)
    else
      "There was an error"
    end
  end


  def destroy_source_path(arg)
    if arg.is_a? Source
      project_source_path( arg.project, arg, method: :delete, data:
                          { confirm: 'Are you sure?' }) 
    else
      "There was an error"
    end
  end

  def new_source_path(arg)
    if arg.is_a? Source
      new_project_source_path(arg.project)
    elsif arg.is_a? Project
      new_project_source_path(arg)
    end
  end

################
## Note paths ##
################

  def notes_path(arg)
    if arg.is_a? Note
      project_source_notes_path(arg.source.project, arg.source, arg)
    else
      "There was an error"
    end
  end
  
  def note_path(arg)
    if arg.is_a? Note
      project_source_note_path(arg.source.project, arg.source, arg)
    else
      "There was an error"
    end
  end
  
  def edit_note_path(arg)
    if arg.is_a? Note
      edit_project_source_note_path(arg.source.project, arg.source, arg)
    else
      "There was an error"
    end
  end
  
  def destroy_note_path(arg)
    if arg.is_a? Note
      project_source_note_path(arg.source.project, arg.source, arg,
                    method: :delete, data: { confirm: 'Are you sure?' }) 
    else
      "There was an error"
    end
  end

  def create_note_path(arg)
    if arg.is_a? Note
      project_source_note_path(arg.source.project, arg.source)
    elsif arg.is_a? Source
      project_source_note_path(arg.project, arg)
    else
      arg.errors
    end
  end

  def new_note_path(arg)
    if arg.is_a? Note
      new_project_source_note_path(arg.source.project, arg.source)
    elsif arg.is_a? Source
      new_project_source_note_path(arg.project, arg)
    else
      arg.errors
    end
  end

#################
## Breadcrumbs ##
#################

end
