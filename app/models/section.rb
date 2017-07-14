class Section < ActiveRecord::Base
  has_many :students_sections, class_name: "StudentsSections"
  has_many :students, through: :students_sections, source: :user

  has_many :teachers_sections, class_name: "TeachersSections"
  has_many :teachers, class_name: "User", through: :teachers_sections, source: :user

  has_many :section_projects
end
