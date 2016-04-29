class AddSectionIdUserIdToUserSectionRelation < ActiveRecord::Migration
  def change
    add_column :user_section_relations, :section_id, :integer
    add_column :user_section_relations, :user_id, :integer
  end
end
