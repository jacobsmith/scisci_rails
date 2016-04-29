class RemoveCompositeIndexCollaborators < ActiveRecord::Migration
  def change
    remove_index :collaborators, [:user_id, :project_id]
  end
end
