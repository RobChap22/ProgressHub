class UserProjectsController < ApplicationController
  before_action :set_user_project, only: [:show, :update]


  def create
    @project = Project.find(params[:project_id])
    @user_project = UserProject.new
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
    @steps = @user_project.project.project_steps.order(:ordinal)
    @message = Message.new
  end

  def update
    if @user_project.update(user_project_params)
      # redirect_to user_project_path(@user_project, anchor: "nav-#{@user_project.last_completed + 1}")
      head :no_content, notice: "Good work!"
    else
      redirect_to user_project_path(@user_project), notice: "Could not be updated."
    end
  end

  private

  def user_project_params
    params.require(:user_project).permit(:last_completed, :completed)
  end

  def set_user_project
    @user_project = UserProject.find(params[:id])
    authorize @user_project
    @steps = @user_project.project.project_steps.order(:ordinal)
    @project = @user_project.project
    @project_step = ProjectStep.new()
  end
end
