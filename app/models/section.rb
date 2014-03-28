class Section < ActiveRecord::Base
  belongs_to :teacher
  has_many :students
  has_many :students, through: :student_section_relation

  validates :project_name_to_deploy, presence: true

  attr_accessor :project_name_to_deploy

  def add_student(student)
    Student_Section_Relation.create(section: self, student: student)
  end

  def deploy_project(project_name)
    teacher = Teacher.find(self.teacher_id.to_i)
    ## allow us to group all projects from a class by a single id (not rely on names) 
    section_project_id = Project.where(section_id: self.id).maximum('section_project_id')
      # if it's not set, set it to 0
    section_project_id ||= 0
      # allows us to use 1.upto(maximum) later
    new_section_project_id = section_project_id + 1

    Student_Section_Relation.where(section: self).each do |relation|
      student = Student.where(id: relation.student_id.to_i).first
      project = Project.create(          user_id: student.id.to_s,
                                            name: project_name,
                                      section_id: self.id,
                                      teacher_id: teacher.id,
                              section_project_id: new_section_project_id )

     project.add_collaborator(student)
    end
  end

  def all_projects(current_user)
    @projects = []
    if current_user.is_a? Student
      @projects = Project.where(user_id: current_user.id, section_id: self.id)
    elsif current_user.is_a? Teacher
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
