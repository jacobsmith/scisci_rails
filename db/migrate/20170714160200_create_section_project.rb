class CreateSectionProject < ActiveRecord::Migration
  def change
    create_table :section_projects do |t|
      t.integer :section_id
      t.string :project_name
      t.timestamps
    end
  end
end
