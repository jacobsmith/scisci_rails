module BreadcrumbsHelper 
  def project_crumb(project = nil)
    project ||= Project.find(params[:project_id])
    add_crumb project.name, projects_path(project)
  end
end
