class AddSourceIdToNote < ActiveRecord::Migration
  def change
    add_column :notes, :source_id, :string
  end
end
