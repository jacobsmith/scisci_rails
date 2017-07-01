class CreateTeachersSections < ActiveRecord::Migration
  def change
    create_table :teachers_sections do |t|
      t.references :user
      t.references :section
    end
  end
end
