class Section < ActiveRecord::Base
  belongs_to :teacher
  has_many :users
  has_many :users, through: :user_section_relation

  def add_user(user)
    User_Section_Relation.create(section: self, user: user) 
  end

  def deploy_project(project_name)
    teacher = Teacher.where(self.teacher_id).first
    User_Section_Relation.where(section_id: self.id).each do |relation|
      user = User.where(id: relation.user_id).first
      project = Project.create(user: teacher, name: project_name,)
      project.add_collaborator(user) 
    end
  end
end
