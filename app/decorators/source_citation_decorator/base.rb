module SourceCitationDecorator
  class Base < SimpleDelegator
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
