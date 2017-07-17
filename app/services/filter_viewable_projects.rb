class FilterViewableProjects
  attr_reader :filtered_sections, :projects, :students

  def self.perform(*args)
    new.tap { |s| s.perform(*args) }
  end

  def perform(section_id:, section_project_id:, current_user:)
    filtered_sections = current_user.taught_sections
    filtered_sections = filtered_sections.where(id: section_id) if section_id.present?
    @filtered_sections = filtered_sections

    projects = Project.where(
      user_id: User.where(
        id: StudentsSections.where(
          section_id: filtered_sections.map(&:id)
          ).pluck(:user_id)
      )
    )

    projects = projects.where(section_project_id: section_project_id) if section_project_id.present? && @filtered_sections.include?(SectionProject.find(section_project_id).section)
    @projects = projects

    @students = [filtered_sections.includes(:students).map(&:students) + @projects.includes(:user).map(&:user)].flatten.uniq

    students_without_project = [@students.map(&:id) - @projects.pluck(:user_id)].flatten
    students_without_project.each do |student_id|
      @projects << NilProject.new(user: User.find(student_id))
    end

  end
end
