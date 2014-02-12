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
end
