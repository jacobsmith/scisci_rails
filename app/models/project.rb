class Project < ActiveRecord::Base
  belongs_to :user
  has_many :sources
  has_many :notes, through: :sources
  has_many :tags

  validates :user_id, presence: true

  def tags
   count = Hash.new(0)
    tags = Tag.all.where(project: self).pluck(:name)
    tags.each do |tag|
    	count[tag] += 1
    end
    count.sort_by { |key, value| value }.reverse.map { |key, value| key }.each do |tag|
    	link_to tag.name, tag
    end
  end
end
