class AddSearchableToUsers < ActiveRecord::Migration
  def change
    add_column :users, :searchable, :boolean
  end
end
