10.times do |n|
  name = Faker::Games::SuperSmashBros.fighter
  password_digest = "pass"
  User.create!(name: name, password_digest: password_digest, admin: false)
end