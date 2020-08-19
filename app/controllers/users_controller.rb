class UsersController < ApplicationController

  def dashboard
    @user_projects = policy_scope(UserProject)
    skip_authorization
    # @user_projects = current_user.user_projects
  end
end
