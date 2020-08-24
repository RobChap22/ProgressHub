class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(published: true)
    end
  end

  def new?
    user
  end

  def create?
    new?
  end

  def update?
    record.user == user
  end

  def index?
    true
  end

  def show?
    true
  end
end
