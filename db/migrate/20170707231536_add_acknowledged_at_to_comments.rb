class AddAcknowledgedAtToComments < ActiveRecord::Migration
  def change
    add_column :comments, :acknowledged_at, :datetime
  end
end
