class ChangeTypeColumnToSourceTypeOnSources < ActiveRecord::Migration
  def change
    remove_column :sources, :type
    add_column :sources, :source_type, :string
  end
end
