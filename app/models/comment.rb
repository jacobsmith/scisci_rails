class Comment < ActiveRecord::Base
  belongs_to :author, class_name: "User"
  belongs_to :commentable, polymorphic: true
  belongs_to :project

  before_save :set_project

  scope :unread, -> { where(acknowledged_at: nil) }
  scope :read, -> { where.not(acknowledged_at: nil) }

  def acknowledged?
    acknowledged_at.present?
  end

  def set_project
    self.project_id = commentable.project.id
    raise "Project is required" unless self.project_id.present?
  end
end
