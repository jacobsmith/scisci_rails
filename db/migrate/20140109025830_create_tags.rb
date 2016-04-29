class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :note_id
      t.string :project_id

      t.timestamps
    end
  end
end
