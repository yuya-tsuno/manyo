FactoryBot.define do
  factory :user do
    name { "test_user" }
    # email { "test@user.com" }
    email { "test#{rand(1..99999)}@user.com" }
    password { "test" }
    admin { false }
  end
end
