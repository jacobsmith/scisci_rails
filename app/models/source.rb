class Source < ActiveRecord::Base
  require 'cite_me'
  include SourcesHelper

  belongs_to :project
  has_many :notes

  validates :project_id, presence: true

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
end
