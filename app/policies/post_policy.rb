class PostPolicy < ApplicationPolicy
  def update?
    record.user_id == user.id || ApplicationPolicy.admin_types.include?(user.type)
  end
end