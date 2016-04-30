class Tag < ActiveRecord::Base
  belongs_to :note
  belongs_to :project

  validates_presence_of :note, :project, :name

  validates :name, uniqueness: { scope: :note }

  def display_name
    name.capitalize
  end
end
