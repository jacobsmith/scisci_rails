module BreadcrumbsHelper 
  def first_n_words( arg, num_words )
    first_words = arg.split(" ")[0..( num_words-1 )].join(" ")
    first_words += "..." if arg.split(" ").length > num_words-1
    first_words
  end

  def project_crumb(project = nil)
    project ||= Project.find(params[:project_id])
    add_crumb project.name, project_path(project)
  end

  def source_crumb(source = nil)
    source ||= Source.find(params[:id])
    add_crumb source.title, source_path(source)
  end
end
