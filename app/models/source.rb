class Source < ActiveRecord::Base
  require 'cite_me'
  include SourcesHelper

  belongs_to :project
  has_many :notes

  validates :project_id, presence: true
  validate :source_title_present

  def cite
    @cite = Cite_Me.new
    @cite.generate_citation self
  end

  def display_title
    case self.source_type
    when 'book'
      self.title
    when 'magazine'
      self.title_of_article
    when 'web'
      self.name_of_site
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

  def source_title_present
    errors.add(:title, "must not be blank.") if self.display_title == ''
  end
 
end
