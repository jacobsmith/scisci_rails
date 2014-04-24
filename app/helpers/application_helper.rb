module ApplicationHelper
  ## the following helper method taken from user Voldy on StackOverflow 
  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end

  def original_link(object)
     link_to "Original Page", url_with_protocol(object.url), 
        target: '_blank' if object.url != ''
  end

  def escape(string)
    new_string = string.gsub("?", "%3F")
    new_string = new_string.gsub(".", "%2E")
  end

  def unique_tags(project)
    unique_tags = Hash.new(0)
    project.tags.each do |tag|
      # only add tag to unique_tags if it is unique (count == 0 in hash)
      if unique_tags[tag.name] == 0
        unique_tags[tag.name] = tag
      end
    end
    # return only the tags themselves so it works with the tag_list function
    unique_tags.values
  end

  def project_title
    if @project
      @project.name
    elsif @source
      @source.project.name
    elsif @note
      @note.source.project.name
    elsif @tag
      @tag.project.name
    end
  end

  def create_modal(id='default', text)
    modal = '<div id="' + id.to_s + '" class="reveal-modal hide" data-reveal>' + 
            '<p>' + text + '</p>' + 
            '<a class="close-reveal-modal">&#215;</a>' + 
            '</div>'

    modal.html_safe
  end
  
  def pretty_display(arg)
    arg.to_s.split("_").join(" ").capitalize
  end

  def display_projects_link?
    @project && @project.id != nil
  end

  def display_sources_link?
     @project && @project.id != nil
  end

  def display_notes_link?
    @project && @project.id != nil
  end
end
