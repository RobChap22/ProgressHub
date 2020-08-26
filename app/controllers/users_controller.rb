class UsersController < ApplicationController

  def dashboard
    @active_projects = current_user.user_projects.joins(:project).where(completed: false).where.not("projects.user_id"=>current_user.id)
    @finished_projects = UserProject.where(completed: true)
    @projects_published =  current_user.user_projects.where(project: current_user.projects.where(published: true))
    @projects_drafts = current_user.user_projects.where(project: current_user.projects.where(published: false))
    skip_authorization
    @quote = Quote.all.sample
    @tag_hash = finished_project_tags
    chart_data = {
        labels: @tag_hash.keys,
        datasets: [{
          data: @tag_hash.values
        }]
      }
    respond_to do |format|
      format.html
      format.json { render json: chart_data } # respond with the created JSON object
    end
  end

  def finished_project_tags
    tag_hash = { "creative" => 0, "tech" => 0, "practical" => 0, "academic" => 0, "lifestyle" => 0, "social" => 0, "easy" => 0, "fun" => 0, "intense" => 0, "moderate" => 0 }
    Project.joins(:user_projects).where(user_projects: {completed: true}).each { |proj| proj.tag_list.each { |tag| tag_hash[tag] += 1}}
    tag_hash
  end
end
