module SourceCitationDecorator
  class Magazine < Base
    def citation_type
      "magazine"
    end

    def citation_type_options
      {
        title: title_of_article
      }
    end

    def pubtype
      "pubmagazine".freeze
    end

    def pubtype_expanded
      opts = OpenStruct.new
      opts.title = title_of_periodical
      opts.vol = volume
      opts.day = day_published
      opts.month = month_published
      opts.year = year_published
      opts.start = article_page_start
      opts.end = article_page_end

      opts
    end

    def volume
      nil
    end

    def article_page_start
      pages.split("-").first
    end

    def article_page_end
      pages.split("-").last
    end

    def day_published
      parsed_publication_date.day
    end

    def month_published
      parsed_publication_date.strftime(MONTH_STRING)
    end

    def year_published
      parsed_publication_date.year
    end

    def parsed_publication_date
      Date.parse(publication_date)
    end

  end
end
