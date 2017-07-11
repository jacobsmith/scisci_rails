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
      opts.title = title_of_periodical
      opts.inst = institution_of_website
      opts.day = date_publisehd.try(:day)
      opts.month = date_publisehd.try(:month).try(:strftime, MONTH_STRING)
      opts.year = date_publisehd.try(:year)
      opts.url = url
      opts.dayaccessed = date_accessed.try(:day)
      opts.monthaccessed = date_accessed.try(:month).try(:strftime, MONTH_STRING)
      opts.yearaccessed = date_accessed.try(:year)

      opts
    end

    def date_publisehd
      Date.parse(publication_date)
    rescue ArgumentError, TypeError
      nil
    end

    def date_accessed
      Date.parse(date_of_access)
    rescue ArgumentError, TypeError
      nil
    end

    def institution_of_website
      name_of_organization
    end
  end
end
