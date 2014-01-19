class AddIndexToCollaborators < ActiveRecord::Migration
  def change
    add_index :collaborators, :project_id
    add_index :collaborators, :user_id
  end
end
