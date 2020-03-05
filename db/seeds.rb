def task_seed(title, content, limit, priority, status, user_id)
    Task.create(title: title, 
                 content: content,
                 limit: limit,
                 priority: priority,
                 status: status,
                 user_id: user_id
                )
end

def user_seeds
  10.times do |n|
    name = Faker::Games::SuperSmashBros.fighter
    #fakerでメアド作るときは/config/initializers/locale.rbをコメントアウトすること
    email = Faker::Internet.email
    password_digest = "pass"
    User.create!(name: name, email: email, password_digest: password_digest, admin: false)
  end
end

user_seeds
task_seed('タスク', 'タスク', '2020-03-01', 1, 0, 1)

#タイトル、コンテンツ違い
task_seed('いいいいい', 'いいいいい', '2020-03-01', 1, 0, 1)
task_seed('ううううう', 'ううううう', '2020-03-01', 1, 0, 1)

#期限違い
task_seed('期限近いタスク', '期限近いタスク', '2020-02-01', 1, 0, 1)
task_seed('期限余裕あるタスク', '期限余裕あるタスク', '2020-04-01', 1, 0, 1)

#優先度違い
task_seed('優先タスク', '優先タスク', '2020-03-01', 0, 0, 1)
task_seed('後回しタスク', '後回しタスク', '2020-03-01', 2, 0, 1)

# ステータス違い
task_seed('着手中タスク', '着手中タスク', '2020-03-01', 1, 1, 1)
task_seed('完了タスク', '完了タスク', '2020-03-01', 1, 2, 1)

# 投稿ユーザー違い
task_seed('ユーザー２の投稿', 'ユーザー２の投稿', '2020-03-01', 1, 0, 2)
task_seed('ユーザー3の投稿', 'ユーザー3の投稿', '2020-03-01', 1, 0, 3)