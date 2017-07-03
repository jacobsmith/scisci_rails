class StudentsController < ApplicationController
  before_action :authorize_user!

  def show
  end

  def project
    @project = Project.find(params[:project_id])
  end

  private

  def authorize_user!
    @student = User.find(params[:id])
    return unauthorized! unless current_user.students.include?(@student)
  end
end
