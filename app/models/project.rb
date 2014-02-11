class Project < ActiveRecord::Base
  belongs_to :user

  # many can collaborate
  has_many :collaborators
  has_many :users, through: :collaborators

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
    count.sort_by { |key, value| value }.reverse.map { |key, value| key }
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
end
