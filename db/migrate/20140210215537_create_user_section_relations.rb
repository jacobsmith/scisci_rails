class CreateUserSectionRelations < ActiveRecord::Migration
  def change
    create_table :user_section_relations do |t|

      t.timestamps
    end
  end
end
