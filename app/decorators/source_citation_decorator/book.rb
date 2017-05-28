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

    def authors_info
      info = []
      authors.split(",").each do |author|
        first, middle, last = author.split(" ")
        author_info = OpenStruct.new
        author_info.function = "author"
        author_info.first = first
        author_info.last = last || middle
        author_info.middle = middle unless last.nil?

        info << author_info
      end

      info
    end
  end
end
