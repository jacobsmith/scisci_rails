module BreadcrumbsHelper 
  def project_crumb(project = nil)
    project ||= Project.find(params[:project_id])
    add_crumb project.name, project_path(project)
  end

  def source_crumb(source = nil)
    source ||= Source.find(params[:id])
    add_crumb source.title, source_path(source)
  end
end
