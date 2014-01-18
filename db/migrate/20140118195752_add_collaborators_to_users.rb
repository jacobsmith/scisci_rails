class AddCollaboratorsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :collaborators, :integer
  end
end
