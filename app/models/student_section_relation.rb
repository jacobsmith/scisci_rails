class Student_Section_Relation < ActiveRecord::Base
  belongs_to :user
  belongs_to :section

  validate :user_type_is_student

  private

  def user_type_is_student
    errors.add(:user_type, "must be a student") if !user.is_a_student?
  end
end
