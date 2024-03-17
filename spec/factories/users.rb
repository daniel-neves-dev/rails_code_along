FactoryBot.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    first_name {"daniel"}
    last_name {"oliveira"}
    email { generate :email }
    password {"123456"}
    password_confirmation {"123456"}
  end

  factory :admin_user, class: "AdminUser" do
    first_name {'Admin'}
    last_name {'User'}
    email { generate :email }
    password {"admin123"}
    password_confirmation {"admin123"}
  end
end