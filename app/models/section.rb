class Section < ActiveRecord::Base
  belongs_to :teacher
  has_many :users
  has_many :users, through: :user_section_relation
end
