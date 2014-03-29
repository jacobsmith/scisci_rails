class AddUserToSourceNoteTags < ActiveRecord::Migration
  def change
    add_column :sources, :user_id, :integer
    add_column :notes, :user_id, :integer
    add_column :tags, :user_id, :integer
  end
end
