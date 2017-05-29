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
      opts.start = article_page_start
      opts.end = article_page_end

      opts
    end

    %w(
      title_of_periodical
      volume
      day_published
      month_published
      article_page_start
      article_page_end
      ).each do |m|
        define_method m do
          "Need to define: #{m}"
        end
      end
  end
end
