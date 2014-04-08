class Tag < ActiveRecord::Base
  belongs_to :note
  belongs_to :project

  validates_presence_of :note, :project, :name
  before_save :sub_out_spaces

  validates :name, uniqueness: { scope: :note }

  def display_name
    self.name.gsub("_", " ").gsub("-", "_")
  end

  private

  def sub_out_spaces
    self.name.gsub!("_", "-")
    self.name.gsub!(" ", "_")
  end

end
