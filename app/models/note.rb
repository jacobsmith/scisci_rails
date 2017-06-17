class Note < ActiveRecord::Base
  include TagsHelper
  belongs_to :source
  belongs_to :project
  has_many :tags, dependent: :destroy

  validates :source_id, presence: true
  validate :quote_or_comments

  def tags=(args)
    args.split(/,|;/).each do |arg|
      arg = arg.strip.capitalize
      if Tag.where(project: self.source.project, name:arg).first
        existing_tag = Tag.where(project: self.source.project, name: arg).first.color
      end

      tag_color = existing_tag || random_color

      if Tag.all.where(note:self, name: arg).empty?
        Tag.create(note: self, project: self.source.project, name: arg, color: tag_color)
      end
    end
  end

  def tags
    tags = Tag.all.where(note: self)
  end

  def unique_tags
    tags.to_a.uniq(&:name)
  end

  def project_wide_tags
    project.try(:project_wide_tags) || []
  end

  def project_tags
   count = Hash.new(0)
    tags = Tag.all.where(project: self.source.project).pluck(:name)
    tags.each do |tag|
      count[tag] += 1
    end
    count.sort_by { |key, value| value }.reverse.map { |key, value| key }
  end

  def existing_tags
    tags = Tag.all.where(note: self).pluck(:name)
    if tags == []
      nil
    else
      tags.join ", "
    end
  end

  private

  def quote_or_comments
    errors.add(:base, "Either quote or comment must be present.") if self.quote == '' && self.comments == ''
  end
end
