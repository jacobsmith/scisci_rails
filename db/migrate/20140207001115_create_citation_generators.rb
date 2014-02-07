class CreateCitationGenerators < ActiveRecord::Migration
  def change
    create_table :citation_generators do |t|

      t.timestamps
    end
  end
end
