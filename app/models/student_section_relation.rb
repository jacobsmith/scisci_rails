class Student_Section_Relation < ActiveRecord::Base
  belongs_to :student
  belongs_to :section
end
