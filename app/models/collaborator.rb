class Collaborator < ActiveRecord::Base
  #ensure that we only have 1 record for each user <=> project relationship
  validates_uniqueness_of :user, scope: :project, 
    message: "That collaboration already exists."
  
  belongs_to :project
  belongs_to :user

end
