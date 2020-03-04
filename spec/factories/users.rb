FactoryBot.define do
  factory :user do
    name { "MyString" }
    password_digest { "MyString" }
    admin { "" }
  end
end
