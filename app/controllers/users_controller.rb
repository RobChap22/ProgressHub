class UsersController < ApplicationController

  def dashboard
    @active_projects = policy_scope(UserProject).where(completed: false)
    @finished_projects = policy_scope(UserProject).where(completed: true)
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
