# frozen_string_literal: true

class CommentPolicy < ApplicationPolicy
  def create?
    !user.guest?
  end

  def update?
    user.admin_role? || user.moderator_role? || user.author?(record)
  end

  def index?
    true
  end

  def show?
    true
  end

  def destroy?
    user.admin_role? || user.author?(record)
  end
end
