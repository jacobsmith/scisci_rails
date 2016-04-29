class AddSectionIdUserIdToUserSectionRelation < ActiveRecord::Migration
  def change
    add_column :user_section_relations, :section_id, :string
    add_column :user_section_relations, :user_id, :string
  end
end
