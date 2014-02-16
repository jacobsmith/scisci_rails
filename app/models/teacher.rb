class Teacher < User
  has_many :sections

  def all_projects
    @projects = []
    @projects << Project.where(user_id: self.id)
    @projects << self.projects_as_collaborator
    @projects
  end
end
