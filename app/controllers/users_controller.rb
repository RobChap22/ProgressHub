class UsersController < ApplicationController

  def dashboard
    @active_projects = current_user.user_projects.joins(:project).where(completed: false).where.not("projects.user_id"=>current_user.id)
    @finished_projects = UserProject.where(completed: true)
    @projects_published =  current_user.user_projects.where(project: current_user.projects.where(published: true))
    @projects_drafts = current_user.user_projects.where(project: current_user.projects.where(published: false))
    skip_authorization
    @quote = Quote.all.sample
  end
end
