module SourcesHelper
  def all_allowed_params
    all_params = []
    all_params << book_information
    all_params << magazine_information
    all_params << web_information
  end
  
  def book_information
    %w[title authors city_of_publication year_of_publication publisher medium]
  end

  def magazine_information
    %w[title_of_article author title_of_periodical publication_date pages]
  end

  def web_information
    %w[author name_of_site name_of_organization date_of_creation date_of_access url]
  end
end
