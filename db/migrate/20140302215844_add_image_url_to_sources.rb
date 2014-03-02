class AddImageUrlToSources < ActiveRecord::Migration
  def change
    add_column :sources, :image_url, :string
  end
end
