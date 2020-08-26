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
    if @project.save
      @user_project = UserProject.find_by(user: current_user, project: @project)
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
    if params[:query].present?
      relevant_projects = []
      relevant_projects << policy_scope(Project).tagged_with(params[:query])
      relevant_projects << policy_scope(Project).where('title ILIKE :query OR description ILIKE :query', query: "%#{params[:query]}%")
      # relevant_projects << policy_scope(Project).where('description ILIKE ?', "%#{params[:query]}%")
      @projects = Project.from("(#{relevant_projects.map(&:to_sql).join(' UNION ')}) AS projects")
    else
      @projects = policy_scope(Project)
    end
  end

  def show
    @steps = @project.project_steps.order(:ordinal)
    @user_project = UserProject.new()
    @reviews = Review.where(project: @project)
  end

  def tagged
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
