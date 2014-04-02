class RenameSchoolSystemToSchoolSystemId < ActiveRecord::Migration
  def change
    rename_column :users, :school_system, :school_system_id
  end
end
