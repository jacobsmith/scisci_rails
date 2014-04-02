class AddSchoolSystemColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :school_system, :integer, default: 0
  end
end
