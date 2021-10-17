# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def create?
    user.guest?
  end

  def update?
    record == user
  end

  def index?
    false
  end

  def show?
    true
  end

  def destroy?
    false
  end
end
