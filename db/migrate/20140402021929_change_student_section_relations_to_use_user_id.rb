class ChangeStudentSectionRelationsToUseUserId < ActiveRecord::Migration
  def change
    remove_column :student_section_relations, :student_id
    add_column :student_section_relations, :user_id, :integer
  end
end
