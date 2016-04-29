class AddCollaboratableFlagToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :collaboratable, :boolean, default: false
  end
end
