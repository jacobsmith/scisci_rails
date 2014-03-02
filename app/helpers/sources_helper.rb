module SourcesHelper
  def all_allowed_params
    all_params = []
    all_params << 'source_type'
    all_params << book_information
    all_params << magazine_information
    all_params << web_information
    all_params << "authors"
    all_params << "comments"
    all_params << "image_url"
    (1..10).each do |i|
      all_params << "authorFirst##{i}"
      all_params << "authorLast##{i}"
    end
    all_params.flatten
  end
  
  def book_information
    %w[title city_of_publication year_of_publication publisher medium]
  end

  def magazine_information
    %w[title_of_article title_of_periodical publication_date pages]
  end

  def web_information
    %w[name_of_site name_of_organization date_of_creation date_of_access url]
  end
end
