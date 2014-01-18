class Note < ActiveRecord::Base
  belongs_to :source
  belongs_to :project
  has_many :tags, dependent: :destroy

  validates :source_id, presence: true
  validates :quote, presence: true

  def tags=(args)
    # impose unique on db instead -- better performance
    args.split(", ").each do |arg|
      Tag.create(note: self, project: self.source.project, name: arg) if
                                     Tag.all.where(note:self, name: arg).empty?
    end
  end

  def tags
   count = Hash.new(0)
    tags = Tag.all.where(project: self.source.project).pluck(:name)
    tags.each do |tag|
      count[tag] += 1
    end
    count.sort_by { |key, value| value }.reverse.map { |key, value| key }
  end

end
