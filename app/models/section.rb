class Section < ActiveRecord::Base
  belongs_to :teacher
  has_many :students
  has_many :students, through: :student_section_relation

  attr_accessor :project_name_to_deploy

  def add_student(student)
    Student_Section_Relation.create(section: self, student: student)
  end

  def deploy_project(project_name)
    teacher = Teacher.find(self.teacher_id.to_i)
    ## allow us to group all projects from a class by a single id (not rely on names) 
    project_section_id = Project.where(section_id: self.id).maximum('section_project_id')
    new_project_section_id = project_section_id + 1

    Student_Section_Relation.where(section: self).each do |relation|
      student = Student.where(id: relation.student_id.to_i).first
      project = Project.create(          user_id: student.id.to_s,
                                            name: project_name,
                                      section_id: self.id,
                                      teacher_id: teacher.id
                              project_section_id: new_project_section_id )

     project.add_collaborator(student)
    end
  end

  def all_projects
    # return all projects in a section (for teacher use)
    @projects = []
    teacher = Teacher.find(self.teacher_id)
    projects = Project.where(teacher_id: teacher.id, section_id: self.id)

    Student_Section_Relation.where(section_id: self.id).each do |relation|
      student = Student.find(relation.student_id)
      projects.each do |project|
        @projects << project if project.all_collaborators.include? student
      end
    end
    @projects
  end

  def user_projects(user)
    # return all projects in a particular section for a user
    @projects = []
    teacher = Teacher.find(self.teacher_id) 
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
