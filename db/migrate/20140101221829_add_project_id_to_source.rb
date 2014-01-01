class AddProjectIdToSource < ActiveRecord::Migration
  def change
    add_column :sources, :project_id, :string
  end
end
