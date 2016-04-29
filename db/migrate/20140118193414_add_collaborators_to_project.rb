class AddCollaboratorsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :collaborators, :integer
  end
end
