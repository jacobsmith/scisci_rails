class NonStiTypeForUsers < ActiveRecord::Migration
  def change
    remove_column :users, :type
    add_column :users, :non_sti_type, :string, default: "Student"
  end
end
