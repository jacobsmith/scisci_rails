class Note < ActiveRecord::Base
  belongs_to :source
  validates :source_id, presence: true

end
