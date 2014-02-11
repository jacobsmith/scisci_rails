class AddIndexToUserSectionRelation < ActiveRecord::Migration
  def change
    add_index :user_section_relations, :section_id
    add_index :user_section_relations, :user_id
  end
end
