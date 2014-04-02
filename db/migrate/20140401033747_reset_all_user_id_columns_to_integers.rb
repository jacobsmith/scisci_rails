class ResetAllUserIdColumnsToIntegers < ActiveRecord::Migration
  def change
      change_column :notes, :source_id, 'integer USING CAST(source_id AS integer)'
      change_column :projects, :user_id, 'integer USING CAST(user_id AS integer)'
      change_column :sections, :teacher_id, 'integer USING CAST(teacher_id AS integer)'
      change_column :sources, :project_id, 'integer USING CAST(project_id AS integer)'
      change_column :tags, :note_id, 'integer USING CAST(note_id AS integer)'
      change_column :tags, :project_id, 'integer USING CAST(project_id AS integer)'
  end
end
