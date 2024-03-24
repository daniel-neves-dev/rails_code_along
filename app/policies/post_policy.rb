class PostPolicy < ApplicationPolicy
  def update?
    (post_approved? && admin?) || (user_or_admin && !post_approved?)
  end

  private

  def user_or_admin
    record.user_id == user.id || admin?
  end

  def admin?
    ApplicationPolicy.admin_types.include?(user.type)
  end

  def post_approved?
    record.approved?
  end
end
