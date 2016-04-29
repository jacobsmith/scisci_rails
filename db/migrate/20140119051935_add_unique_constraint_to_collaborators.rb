class AddUniqueConstraintToCollaborators < ActiveRecord::Migration
  def change
    add_index :collaborators, [:user_id, :project_id], unique: true
  end
end
