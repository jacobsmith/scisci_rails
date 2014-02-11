class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :teacher_id
      t.string :name
      t.timestamps
    end
  end
end
