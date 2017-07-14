class SectionProject < ActiveRecord::Base
  belongs_to :section
  has_many :projects
end
