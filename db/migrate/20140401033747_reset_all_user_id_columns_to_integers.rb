class ResetAllUserIdColumnsToIntegers < ActiveRecord::Migration
  def change
     change_column :notes, :source_id, :integer
     change_column :projects, :user_id, :integer
     change_column :sections, :teacher_id, :integer
     change_column :sources, :project_id, :integer
     change_column :tags, :note_id, :integer
     change_column :tags, :project_id, :integer
  end
end
