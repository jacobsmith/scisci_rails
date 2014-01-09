class Note < ActiveRecord::Base
  belongs_to :source
  belongs_to :project
  has_many :tags, dependent: :destroy

  validates :source_id, presence: true

  def tags=(args)
    args.split(", ").each do |arg|
      Tag.create(note: self, project: self.source.project, name: arg)
    end
  end

  def tags
    Tag.where(note: self).pluck(:name)
  end
end
