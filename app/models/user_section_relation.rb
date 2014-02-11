class User_Section_Relation < ActiveRecord::Base
  belongs_to :user
  belongs_to :section
end
