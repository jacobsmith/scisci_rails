class CreateStudentSectionRelations < ActiveRecord::Migration
  def change
    create_table :student_section_relations do |t|
      t.integer :student_id
      t.integer :section_id
    end
  end
end
