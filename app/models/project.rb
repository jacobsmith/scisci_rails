class Project < ActiveRecord::Base
  belongs_to :user
  has_many :sources
  has_many :notes, through: :sources
  has_many :tags

  validates :user_id, presence: true

  def tags
    Tag.all.where(project: self).pluck(:name)
  end
end
