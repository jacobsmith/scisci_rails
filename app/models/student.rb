class Student < User 
  belongs_to :student_section_relation

  def all_projects
    @projects = []
    @projects << Project.where(user_id: self.id)
    @projects << self.projects_as_collaborator
    @projects
  end
end
