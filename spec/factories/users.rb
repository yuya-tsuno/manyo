FactoryBot.define do
  factory :user do
    name { "test_user" }
    email { "test@user.com" }
    password { "test" }
    admin { false }
  end
end
