class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :quote
      t.text :comments

      t.timestamps
    end
  end
end
