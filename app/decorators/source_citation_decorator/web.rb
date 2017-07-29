module SourceCitationDecorator
  class Web < Base
    def citation_type
      "website"
    end

    def citation_type_options
      {
        title: title_of_article
      }
    end

    def pubtype
      "pubonline".freeze
    end

    def pubtype_expanded
      opts = OpenStruct.new
      opts.title = name_of_site
      opts.inst = institution_of_website
      opts.day = date_published.try(:day)
      opts.month = date_published.try(:strftime, "%B")
      opts.year = date_published.try(:year)
      opts.url = url
      opts.dayaccessed = date_accessed.try(:day)
      opts.monthaccessed = date_accessed.try(:strftime, "%B")
      opts.yearaccessed = date_accessed.try(:year)

      opts
    end

    def date_published
      AmericanDate.parse(publication_date)
    end

    def date_accessed
      AmericanDate.parse(date_of_access)
    end

    def institution_of_website
      name_of_organization
    end
  end
end
