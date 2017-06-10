class Source < ActiveRecord::Base
  require 'cite_me'
  include SourcesHelper

  BOOK = "book".freeze
  MAGAZINE = "magazine".freeze
  WEB = "web".freeze

  belongs_to :project
  has_many :notes

  validates :project_id, presence: true
  validate :source_title_present

  def cite
    @cite = Citation.new
    @cite.generate_citation(source_citation_decorator)
  end

  def source_citation_decorator
    case source_type
    when Source::BOOK
      SourceCitationDecorator::Book.new(self)
    when Source::MAGAZINE
      SourceCitationDecorator::Magazine.new(self)
    when Source::WEB
      SourceCitationDecorator::Web.new(self)
    else
      raise "Unknown source_type: #{source_type}"
    end
  end

  def display_properties
    properties = {}

    if self.source_type == 'book'
       properties[:title] = self.display_title
       properties[:authors] = self.authors
       properties[:date_published] = self.year
       properties[:publisher] = self.publisher

    elsif self.source_type == 'magazine'
       properties[:title] = self.display_title
       properties[:authors] = self.authors
       properties[:date_published] = self.year
       properties[:periodical_name] = self.title_of_periodical

    elsif self.source_type == 'web'
       properties[:title] = self.display_title
       properties[:authors] = self.authors
       properties[:date_published] = self.date_of_creation
       properties[:url] = self.url
    end

    properties[:comments] = self.comments
    return properties
  end

  def display_title
    return self.title if self.source_type == 'book'
    return self.title_of_article if self.source_type == 'magazine'
    return self.name_of_site if self.source_type == 'web'
  end

  def year
    return self.year_of_publication if self.source_type == 'book'
    return self.publication_date if self.source_type == 'magazine'
    return self.date_of_creation if self.source_type == 'web'
  end

  def update_image
    ## only update if image_url is blank from form
    if self.image_url == ''
      if self.source_type == 'book'
        self.image_url = ('/book-placeholder.jpg')
      elsif self.source_type == 'magazine'
        self.image_url = ('/journal-placeholder.jpg')
      elsif self.source_type == 'web'
        self.image_url = ('/web-placeholder.jpg')
      end
    end
  end

  private

  def source_title_present
    errors.add(:title, "must not be blank.") if self.display_title == ''
  end
end
