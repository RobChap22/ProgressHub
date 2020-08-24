class UserProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def create?
    user
  end

  def show?
    record.user == user
  end

  def update?
    record.user == user
  end
end
