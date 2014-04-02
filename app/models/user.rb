require 'pry'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, length: { minimum: 3 }, uniqueness: {scope: :school_system_id }

  has_many :collaborators # is_a collaborator on many projects
  has_many :projects, through: :collaborators

  def email_required?
    false
  end

  def all_projects
    @projects = []
    @projects << Project.where(user_id: self.id)
#    @projects << self.projects_as_collaborator
    @projects.flatten!
  end
  
     def projects_as_collaborator
    # return all projects in which user is a collaborator
    @projects = []
    self.collaborators.map { |collab| @projects << Project.find(collab.project_id)}
    @projects
  end

  def can_read?(arg)
    case arg
      when Project
        user_read? arg
      when Source
        user_read? arg.project
      when Note
        user_read? arg.source.project
      when Tag
        user_read? arg.project
    end
  end

  def is_a_student?
    self.non_sti_type == "Student"
  end

  def is_a_teacher?
    self.non_sti_type == "Teacher"
  end

  private

  def user_read?(arg)
    possible_authorized = []
    self.collaborators.map { |collab| possible_authorized << true if collab.user_id == self.id }
    possible_authorized << ( arg.user.id == self.id )
    possible_authorized << (arg.teacher_id == self.id)
    # as boolean values were put into the array, we check against a boolean
    possible_authorized.include? true
  end

end
