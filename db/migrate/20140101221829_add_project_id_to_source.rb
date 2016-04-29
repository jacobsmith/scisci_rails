class AddProjectIdToSource < ActiveRecord::Migration
  def change
    add_column :sources, :project_id, :integer
  end
end
