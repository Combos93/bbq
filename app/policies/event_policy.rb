class EventPolicy < ApplicationPolicy
  def show?
    user_is_owner?(record)
  end

  def update?
    user_is_owner?(record)
  end

  def destroy?
    update?
  end

  def edit?
    update?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  private

  def user_is_owner?(event)
    user.present? && (event.try(:user) == user)
  end
end
