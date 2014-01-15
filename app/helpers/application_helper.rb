module ApplicationHelper
  ## the following helper method taken from user Voldy on StackOverflow 
  def url_with_protocol(url)
    /^http/.match(url) ? url : "http://#{url}"
  end
end
