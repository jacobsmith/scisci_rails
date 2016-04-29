class RemoveUserSectionRelations < ActiveRecord::Migration
  def change
    drop_table :user_section_relations
  end
end
