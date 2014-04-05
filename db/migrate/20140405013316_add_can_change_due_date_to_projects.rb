class AddCanChangeDueDateToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :can_change_due_date, :boolean, default: false
  end
end
