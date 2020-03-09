FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    limit { '2020-01-01' }
    priority { 2 }
    user { name { "test_user" }
           email { "test@user.com" }
           password { "test" }
           admin { false }
          }
  end
end