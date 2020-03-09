FactoryBot.define do
  factory :task do
    title { 'task' }
    content { 'task' }
    limit { '2020-02-01' }
    status { 0 }
    priority { 1 }
    association :user #これするとuer.rbのファクトリーボット参照して、毎回userを作成します。メアドのユニークネスエラー起こします。
  end
end