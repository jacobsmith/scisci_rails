module RoutesHelper
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

  def source_path(arg)
    if arg.is_a? Source
      project_source_path(arg.project, arg)
    else
      "There was an error"
    end
  end

  def destroy_source_path(arg)
    if arg.is_a? Source
      project_source_path( arg.project, arg, method: :delete, data: { confirm: 'Are you sure?' }) 
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
end
