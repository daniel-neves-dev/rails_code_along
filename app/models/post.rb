class Post < ApplicationRecord
  validates :date, :rationale, presence: true
  belongs_to :user

  enum status: {submitted: 0, approved:1, rejected: 2}

  scope :post_by, ->(user) { where(user_id: user.id) }

end
