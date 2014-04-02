class MakeUsersStudentsByDefault < ActiveRecord::Migration
  def change
    change_column :users, :type, :string, default: "Student"
  end
end
