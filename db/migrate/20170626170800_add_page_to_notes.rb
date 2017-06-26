class AddPageToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :page, :string
  end
end
