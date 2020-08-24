class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update]

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user
    authorize @project
    @user_project = UserProject.create(user: current_user, project: @project)
    if @project.save
      redirect_to user_project_path(@user_project)
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to dashboard_path, notice: "Published #{@project.title} project"
    else
      render "user_projects/show"
    end
  end

  def index
    @projects = policy_scope(Project)
  end

  def show
    @steps = @project.project_steps.order(:ordinal)
    @user_project = UserProject.new()
  end

  private

  def set_project
    @project = Project.find(params[:id])
    authorize @project
  end

  def project_params
    params.require(:project).permit(:title, :description, :photo, :published, tag_list: [])
  end
end
