class Section < ActiveRecord::Base
  belongs_to :teacher
  has_many :users
  has_many :users, through: :user_section_relation

  attr_accessor :project_name_to_deploy

  def add_user(user)
    User_Section_Relation.create(section: self, user: user) 
  end

  def deploy_project(project_name)
    teacher = User.find(self.teacher_id)
    User_Section_Relation.where(section_id: self.id).each do |relation|
      user = User.where(id: relation.user_id).first
      project = Project.create(user_id: teacher.id, name: project_name)
      project.add_collaborator(user) 
    end
  end

  def all_projects
    # return all projects in a section (for teacher use)
    @projects = []
    teacher = User.find(self.teacher_id) 
      projects = Project.where(user_id: teacher.id)
    User_Section_Relation.where(section_id: self.id).each do |relation|
      user = User.find(relation.user_id)
      projects.each do |project|
        @projects << project if project.all_collaborators.include? user
      end
    end
    @projects
  end

  def user_projects(user)
    # return all projects in a particular section for a user
    @projects = []
    teacher = User.find(self.teacher_id) 
    projects = Project.where(user_id: teacher.id)
    user_relation = User_Section_Relation.where(section_id: self.id, user_id: user.id).first
    projects.each do |project|
      @projects << project if project.all_collaborators.include? user
    end
    @projects
  end

  def new_project_name
  end
end
