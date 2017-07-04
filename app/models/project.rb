class Project < ActiveRecord::Base
  belongs_to :user

  has_many :sources
  has_many :notes, through: :sources
  has_many :tags
  has_many :feedback, as: :commentable, class_name: "Comment"

  validates :user_id, presence: true

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  def inactive?
    !active?
  end

  def tags
   count = Hash.new(0)
    tags = Tag.all.where(project: self)
    tags.each do |tag|
    	count[tag] += 1
    end
    count.sort_by { |key, value| value }.reverse.map { |key, value| key }
  end

  def unique_tags
    Tag.where(project: self).to_a.uniq(&:name)
  end

  def project_wide_tags
    unique_tags
  end

  def tag_links
    args = self.tags
    responds_to format.html do
      args.collect { |tag| link_to(tag, "projects/#{@project.id}/tags/#{tag}" ) }.html_safe
    end
  end

  def add_collaborator(user)
    self.collaborators.create(user_id: user.id, project: self)
  end

  def all_collaborators
    @users = []
    self.collaborators.map { |collab| @users << User.find(collab.user_id) }
    @users
  end

  def days_until_due
    if self.due_date
        date_due = Date.strptime(self.due_date, '%m/%d/%Y')
      ( date_due - Date.today).to_i
    end
  end
end
