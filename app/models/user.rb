class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, length: { minimum: 3 }, uniqueness: {scope: :school_system_id }

  has_many :projects

  def email_required?
    false
  end

  def sections
    sections = []
    if self.is_a_student?
      Student_Section_Relation.where(user: self).each do |section_relation|
        sections << Section.where(id: section_relation.section_id)
      end
    end
    return sections
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

  def can_create_new_projects?
    if current_plan == "unlimited_active_projects"
      true
    elsif current_plan == "5_active_projects" && projects.active.size < 5
      true
    elsif current_plan == "3_active_projects" && projects.active.size < 3
      true
    elsif current_plan == "1_active_projects" && projects.active.size < 1
      true
    else
      false
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
