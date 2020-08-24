class ProjectStepsController < ApplicationController

  def create
    @project = Project.find(params[:project_id])
    @user_project = UserProject.find_by(project: @project, user: current_user)
    @project.user = current_user
    @project_step = ProjectStep.new(project_step_params)
    last_step = @project.project_steps.last
    @project_step.ordinal = last_step ? (last_step.ordinal + 1) : 1
    @project_step.project = @project
    authorize @project_step

    if @project_step.save
      redirect_to user_project_path(@user_project), notice: "Added step successfully"
    else
      render "user_projects/show"
    end
  end

  def project_step_params
    params.require(:project_step).permit(:header, :description, :photo)
  end
end
