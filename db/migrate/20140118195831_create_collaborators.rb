class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.integer :project_id
      t.integer :user_id
    end
  end
end
