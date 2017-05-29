require 'pry'

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
      opts.day = date_publisehd.day.to_s
      opts.month = date_publisehd.month.to_s
      opts.year = date_publisehd.year.to_s
      opts.url = url
      opts.dayaccessed = date_accessed.day.to_s
      opts.monthaccessed = date_accessed.month.to_s
      opts.yearaccessed = date_accessed.year.to_s

      opts
    end

    def date_publisehd
      publication_date.present? ? Date.parse(publication_date) : OpenStruct.new(day: "", month: "", year: "")
    end

    def date_accessed
      date_of_access.present? ? Date.parse(date_of_access) : OpenStruct.new(day: "", month: "", year: "")
    end

    %w(
      institution_of_website
      day_published
      month_published
    ).each do |m|
      define_method m do
        "Need to define: #{m}"
      end
    end
  end
end
