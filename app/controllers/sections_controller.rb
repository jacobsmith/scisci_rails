class SectionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :load_section, only: [:show]

  def index
    @sections = current_user.taught_sections
    return unauthorized! unless @sections.any?

    # not sure how to only require "sections" sometimes in params,
    # so this is a hack to only use strong params if params["sections"] is set

    @filtered_sections = if params["sections"] && filterable_params.any?
      @sections.where(filterable_params)
    else
      @sections
    end

    @students = @filtered_sections.map(&:students).flatten.sort_by(&:nickname)
  end

  def show
    unauthorized! unless current_user.taught_sections.include?(@section)
  end

  private

  def load_section
    @section = Section.find(params[:id])
  end

  def filterable_params
    params.require(:sections).permit(
      :name
    )
  end
end
