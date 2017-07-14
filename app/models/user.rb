class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, length: { minimum: 3 }, uniqueness: {scope: :school_system_id }

  has_many :projects
  has_many :students_sections, class_name: "StudentsSections"
  has_many :teachers_sections, class_name: "TeachersSections"

  has_many :taught_sections, class_name: "Section", through: :teachers_sections, source: :section
  has_many :enrolled_sections, class_name: "Section", through: :students_sections, source: :section
  has_many :students, through: :taught_sections

  def email_required?
    false
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

  # setting everyone to be able to create unlimited projects for now
  def can_create_new_projects?
    true
    # if current_plan == "unlimited_active_projects"
    #   true
    # elsif current_plan == "5_active_projects" && projects.active.size < 5
    #   true
    # elsif current_plan == "3_active_projects" && projects.active.size < 3
    #   true
    # elsif current_plan == "1_active_project" && projects.active.size < 1
    #   true
    # else
    #   false
    # end
  end

  def has_paid_plan?
    ["3_active_projects", "5_active_projects", "unlimited_active_projects"].include? current_plan
  end

  def current_plan
    read_attribute(:current_plan) || "1_active_project"
  end

  private

  def user_read?(arg)
    possible_authorized = []
    possible_authorized << ( arg.user.id == self.id )
    # as boolean values were put into the array, we check against a boolean
    possible_authorized.include? true
  end

end
