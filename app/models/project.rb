class Project < ActiveRecord::Base
  belongs_to :user
  has_many :sources
  has_many :notes, through: :sources

  validates :user_id, presence: true

end
