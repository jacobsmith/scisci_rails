module SourceCitationDecorator
  class Book < Base
    def citation_type
      "book"
    end

    def citation_type_options
      {}
    end

    def pubtype
      "pubnonperiodical".freeze
    end

    def pubtype_expanded
      opts = OpenStruct.new
      opts.title = title
      opts.publisher = publisher
      opts.city = city_of_publication
      opts.year = year_of_publication

      opts
    end

  end
end
