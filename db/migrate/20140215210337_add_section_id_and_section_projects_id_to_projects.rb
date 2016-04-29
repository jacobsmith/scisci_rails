class AddSectionIdAndSectionProjectsIdToProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :is_sectioned, :boolean, default: false
    add_column :projects, :section_id, :integer 
    add_column :projects, :section_project_id, :integer 
  end
end
