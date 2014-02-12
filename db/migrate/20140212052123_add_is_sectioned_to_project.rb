class AddIsSectionedToProject < ActiveRecord::Migration
  def change
    add_column :projects, :is_sectioned, :boolean, default: false
  end
end
