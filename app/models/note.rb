class Note < ActiveRecord::Base
  belongs_to :source
  belongs_to :project

  validates :source_id, presence: true

end
