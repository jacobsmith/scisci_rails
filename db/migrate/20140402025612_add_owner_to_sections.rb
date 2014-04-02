class AddOwnerToSections < ActiveRecord::Migration
  def change
    add_column :sections, :owner_id, :integer
  end
end
