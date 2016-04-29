class AddProjectIdAsIndexToSources < ActiveRecord::Migration
  def change
    add_index :sources, :project_id
  end
end
