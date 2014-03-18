module BreadcrumbsHelper 
  def first_n_words( arg, num_words )
    first_words = arg.split(" ")[0..( num_words-1 )].join(" ")
    first_words += "..." if arg.split(" ").length > num_words-1
    first_words
  end

#  def project_crumb(project = nil)
#    project ||= Project.find(params[:project_id])
#    link_name = first_n_words(project.name, 8)
#    if project.name == link_name
#      add_crumb link_name, project_path(project) 
#    else
#      #tooltip
#    add_crumb link_with_tooltip(project_path(project), link_name, project.name)
#    end
#  end
#
#  def source_crumb(source = nil)
#    source ||= Source.find(params[:id])
#    link_name = first_n_words(source.title, 8)
#    if source.title == link_name
#      add_crumb link_name, source_path(source) 
#    else
#      #tooltip
#    add_crumb link_with_tooltip(source_path(source), link_name, source.title)
#    end
#  end
#
  def link_with_tooltip(link_target, link_text, tooltip_text)
    "<a href='#{link_target}'><span data-tooltip class='has-tip', title='#{tooltip_text}'>#{link_text}</span></a>".html_safe
  end
end
