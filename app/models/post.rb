class Post < ApplicationRecord
  validates :date, :rationale, presence: true

  belongs_to :user
end
