class UsersController < ApplicationController

  def dashboard
    @active_projects = current_user.user_projects.joins(:project).where(completed: false).where.not("projects.user_id"=>current_user.id)
    @finished_projects = UserProject.where(completed: true)
    @projects_published =  current_user.user_projects.where(project: current_user.projects.where(published: true))
    @projects_drafts = current_user.user_projects.where(project: current_user.projects.where(published: false))
    skip_authorization
    @quote = Quote.all.sample
    @tag_hash = finished_project_tags
  end

  def finished_project_tags
    tag_hash = Hash.new(0)
    Project.joins(:user_projects).where(user_projects: {completed: true}).each { |proj| proj.tag_list.each { |tag| tag_hash[tag] += 1}}
    tag_hash
  end
end
