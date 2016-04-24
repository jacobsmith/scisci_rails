class Section < ActiveRecord::Base
  has_many :teachers, through: :teacher_section_relation
  has_many :students, through: :student_section_relation

  has_one :owner

  # used in sections#show to give the form an anchor
  attr_accessor :project_name_to_deploy

  def add_student(student)
    Student_Section_Relation.create(section: self, user: student)
  end

  def set_section_project_id
    section_project_id = Project.where(section_id: self.id).maximum('section_project_id')
    section_project_id ||= 0
  end

  def deploy_project(project_name, due_date = "")
    teacher = User.find(self.teacher_id.to_i)

    # group this 'deployed project' into one collection via 'section_project_id' on project
    section_project_id = set_section_project_id
    new_section_project_id = section_project_id + 1

    Student_Section_Relation.where(section: self).each do |relation|
      student = User.where(id: relation.user_id.to_i).first
      project = Project.create(
        user_id: student.id.to_s,
        name: project_name,
        section_id: self.id,
        teacher_id: teacher.id,
        section_project_id: new_section_project_id ,
        due_date: due_date
      )

     project.add_collaborator(student)
    end
  end

  def modify_project(section_project_id, params = {})
    section_projects = Project.where(section_project_id: section_project_id)
    section_projects.each do |project|
      project.update(params)
      project.save
    end
  end

  def all_projects(current_user)
    @projects = []
    if current_user.is_a_student?
      @projects = Project.where(user_id: current_user.id, section_id: self.id)
    elsif current_user.is_a_teacher?
      # loop through any section_project_id (each project in a section has 1 across students)
      maximum = Project.where(section_id: self.id).maximum('section_project_id')
      if maximum != nil
        1.upto(maximum) do |i|
          @projects << Project.where(section_id: self.id, teacher_id: current_user.id, section_project_id: i).first
        end
      end
    end
    @projects
  end

  def user_projects(user)
    # return all projects in a particular section for a user
    @projects = []
    teacher = User.find(self.teacher_id)
    projects = Project.where(teacher_id: teacher.id)
    user_relation = User_Section_Relation.where(section_id: self.id, user_id: user.id).first
    projects.each do |project|
      @projects << project if project.all_collaborators.include? user
    end
    @projects
  end

  def new_project_name
  end
end
