class CreateSections2017 < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.timestamps
    end
  end
end
