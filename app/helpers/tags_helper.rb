module TagsHelper
  def tag_list(tags_owner)
    ## allow project, source, or note to be passed in 

    if tags_owner.is_a? Project 
      args = tags_owner.tags
      project = tags_owner
    elsif tags_owner.is_a? Source
      args = tags_owner.project.tags
      project = tags_owner.project
    else tags_owner.is_a? Note
      args = tags_owner.tags
      project = tags_owner.source.project
    end

    tags = ''
    tags += '<ul class="tag-list">'
    args.each do |tag|
      tags += '<li class="tag">'
      tags += link_to tag.name, project_tags_path(project, tag.name), style:"background-color:"+ tag.color.to_s + ";"
      tags += '</li>'
    end
    tags += '</ul>'
    tags.html_safe
  end

  def click_to_add_tags(tags_owner)
    tags_owner.is_a?( Project ) ? args = tags_owner.tags : args = tags_owner.source.project.tags
    tags_owner.is_a?( Project ) ? project = tags_owner : project = tags_owner.source.project
    links = ''
    args.collect { |tag| links += link_to(tag, "#", onclick:"addText('#{tag}','note_existing_tags'); return false;" ) + ' ' }
    links.html_safe
  end

  def random_color
    # taken from:
    # http://martin.ankerl.com/2009/12/09/how-to-create-random-colors-programmatically/
    # use golden ratio
    golden_ratio_conjugate = 0.618033988749895
    h = rand # use random start value

    h += golden_ratio_conjugate
    h %= 1
    color = hsv_to_rgb(h, 0.5, 0.95)
      ## taken from: https://gist.github.com/Jared-Prime/2423065
    hex = "#"
    color.each { |component| hex << component.to_s(16) }
    hex.upcase
  end

  private



  # HSV values in [0..1[
  # returns [r, g, b] values from 0 to 255
  def hsv_to_rgb(h, s, v)
    h_i = (h*6).to_i
    f = h*6 - h_i
    p = v * (1 - s)
    q = v * (1 - f*s)
    t = v * (1 - (1 - f) * s)
    r, g, b = v, t, p if h_i==0
    r, g, b = q, v, p if h_i==1
    r, g, b = p, v, t if h_i==2
    r, g, b = p, q, v if h_i==3
    r, g, b = t, p, v if h_i==4
    r, g, b = v, p, q if h_i==5
    [(r*256).to_i, (g*256).to_i, (b*256).to_i]
  end

end
