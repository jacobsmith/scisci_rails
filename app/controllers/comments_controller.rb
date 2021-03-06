class CommentsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])

    return unauthorized! unless @project.user == current_user

    @unread_feedback = Comment.where(project: @project).unread
    @read_feedback = Comment.where(project: @project).read
  end

  def create
    commentable_type = params[:commentable][:class]
    commentable_id = params[:commentable][:id]

    obj = commentable_type.constantize.send(:find, commentable_id)

    return unauthorized! unless can_view?(obj)

    if obj.feedback.create(
        author: current_user,
        comment: params[:feedback]
      )
      render :success, locals: { obj: obj }
    else
      render :error
    end

  rescue ActiveRecord::RecordNotFound
    return unauthorized!
  end

  def acknowledge
    comment = Comment.find(params[:id])

    return unauthorized! unless comment.commentable.user == current_user

    comment.acknowledged_at = Time.current
    comment.save

    @link_to_commentable = params[:link_to_commentable]
    @comment = comment
  end

  private

  def can_view?(obj)
    current_user.students.include?(obj.project.user)
  end
end
