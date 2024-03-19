FactoryBot.define do
  factory :post do
    date { Date.today }
    rationale { "Some Rationale" }
    user { association :user, strategy: :create }
  end

  factory :second_post, class: 'Post' do
    date { Date.yesterday }
    rationale { "Some more content" }
    user { association :user, strategy: :create }
  end
end
