class UsersController < ApplicationController

  def dashboard
    @active_projects = policy_scope(UserProject).where(completed: false)
    @finished_projects = policy_scope(UserProject).where(completed: true)
    skip_authorization
    @quote = Quote.all.sample
  end
end
