module SourceCitationDecorator
  class Base < SimpleDelegator
    MONTH_STRING = "%B"

    def self.decorate!(source)
      case source.source_type
      when Source::BOOK
        SourceCitationDecorator::Book.new(source)
      when Source::MAGAZINE
        SourceCitationDecorator::Magazine.new(source)
      when Source::WEB
        SourceCitationDecorator::Web.new(source)
      else
        raise "Unknown source_type: #{source_type}"
      end
    end

    def authors_info
      info = []

      (authors || "").split(",").each do |author|
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
