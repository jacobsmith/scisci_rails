class Source < ActiveRecord::Base
  belongs_to :project
  has_many :notes

  validates :project_id, presence: true
end
