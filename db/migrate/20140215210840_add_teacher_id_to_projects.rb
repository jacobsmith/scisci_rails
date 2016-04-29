class AddTeacherIdToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :teacher_id, :integer
  end
end
