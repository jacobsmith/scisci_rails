module TagsHelper
  def tags_list(tags_owner)
    args = tags_owner.tags
    tags_owner.is_a?( Project ) ? project = tags_owner : project = tags_owner.source.project
    links = ''
    args.collect { |tag| links += link_to(tag, "/projects/#{project.id}/tags/#{tag}" ) + ' ' }
    links.html_safe
  end
end
