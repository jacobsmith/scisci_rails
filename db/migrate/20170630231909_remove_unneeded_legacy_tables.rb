class RemoveUnneededLegacyTables < ActiveRecord::Migration
  def change
    drop_table :sections
    drop_table :student_section_relations
    drop_table :teachers
  end
end
