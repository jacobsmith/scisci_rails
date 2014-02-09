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
end
