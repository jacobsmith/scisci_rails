class CommentsController < ApplicationController
  def create
    commentable_type = params[:commentable][:class]
    commentable_id = params[:commentable][:id]

    obj = commentable_type.constantize.send(:find, commentable_id)

    return unauthorized! unless can_view?(obj)
    puts "Commentable: #{commentable_type}:#{commentable_id}"

  rescue ActiveRecord::RecordNotFound
    return unauthorized!
  end

  private

  def can_view?(obj)
    case obj
    when Note
      current_user.students.include?(obj.project.user)
    end
  end
end
