class Project < ActiveRecord::Base
  belongs_to :user
  has_many :sources

  validates :user_id, presence: true

end
