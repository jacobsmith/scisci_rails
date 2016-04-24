class Teacher_Section_Relation < ActiveRecord::Base
  belongs_to :user
  belongs_to :section

  validate :user_type_is_teacher

  private

  def user_type_is_teacher
    errors.add(:user_type, "must be a teacher") unless user.is_a_teacher?
  end
end
