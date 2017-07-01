class CreateStudentsSections < ActiveRecord::Migration
  def change
    create_table :students_sections do |t|
      t.references :user
      t.references :section
    end
  end
end
