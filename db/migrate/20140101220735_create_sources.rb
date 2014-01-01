class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.string :title
      t.string :author
      t.string :url
      t.text :comments

      t.timestamps
    end
  end
end
