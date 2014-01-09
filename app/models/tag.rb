class Tag < ActiveRecord::Base
  belongs_to :note
  belongs_to :project

  validates_presence_of :note, :project, :name

end
