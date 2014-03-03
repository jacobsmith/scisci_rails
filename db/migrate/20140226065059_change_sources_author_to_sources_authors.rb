class ChangeSourcesAuthorToSourcesAuthors < ActiveRecord::Migration
  def change
    rename_column :sources, :author, :authors
  end
end
