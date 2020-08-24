class UserProjectsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @user_project = UserProject.new()
    @user_project.user = current_user
    @user_project.project = @project
    authorize @user_project
    if @user_project.save
      redirect_to user_project_path(@user_project), notice: "Great choice, #{current_user.username}!"
    else
      render 'projects/show'
    end
  end

  def show
    @user_project = UserProject.find(params[:id])
    authorize @user_project
    @steps = @user_project.project.project_steps.order(:ordinal)
    @project = @user_project.project
    @project_step = ProjectStep.new()
  end
end
