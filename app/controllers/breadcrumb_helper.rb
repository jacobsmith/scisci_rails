module BreadcrumbHelper
  def first_n_words( arg, num_words )
  first_words = arg.split(" ")[0..( num_words-1 )].join(" ")
  first_words += "..." if arg.split(" ").length > num_words-1
  first_words
  end

  def project_crumb
#    add_crumb @project.name, @project
  end

  def source_crumb
#    title = first_n_words(@source.title, 8)
#    add_crumb title, source_path(@source)
  end

  def note_crumb
#    @quote_split = first_n_words(@note.quote, 8)
#    add_crumb @quote_split, ''
  end
end
