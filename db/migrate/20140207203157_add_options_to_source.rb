class AddOptionsToSource < ActiveRecord::Migration
  ## leaving them all as :strings because their inputs will be
  ## an HTML form, so they will all come in :strings

  def change
    add_column :sources, :type, :string
    add_column :sources, :authors, :string
    add_column :sources, :city_of_publication, :string
    add_column :sources, :year_of_publication, :string
    add_column :sources, :publisher, :string
    add_column :sources, :medium, :string

    add_column :sources, :title_of_article, :string
    add_column :sources, :title_of_periodical, :string
    add_column :sources, :publication_date, :string
    add_column :sources, :pages, :string

    add_column :sources, :name_of_site, :string
    add_column :sources, :name_of_organization, :string
    add_column :sources, :date_of_creation, :string
    add_column :sources, :date_of_access, :string

  end
end
