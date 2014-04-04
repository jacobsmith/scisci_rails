class AddThesisToProject < ActiveRecord::Migration
  def change
    add_column :projects, :student_defined_title, :text
    add_column :projects, :thesis, :text
  end
end
