class AddSourceIdAsIndexToNotes < ActiveRecord::Migration
  def change
    add_index :notes, :source_id
  end
end
