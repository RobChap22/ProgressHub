class ProjectsController < ApplicationController
  before_action :set_project, only: [:show]

  def index
    @projects = policy_scope(Project)
  end

  def show
    @steps = @project.project_steps.order(:ordinal)
  end

  private

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end
end