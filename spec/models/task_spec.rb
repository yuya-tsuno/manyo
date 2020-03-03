require 'rails_helper'

RSpec.describe Task, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト')
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '')
    # binding.pry
    expect(task).not_to be_valid
  end

  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.create(title: '成功テスト', content: '成功テスト')
    # binding.irb
    expect(task).to be_valid
  end

  it '検索に入力された文字を含むtitleのみを取得する' do
    task1 = Task.create(title: '成功テスト', content: '成功テスト', status: '着手中')
    task2 = Task.create(title: 'titleによる失敗テスト', content: '失敗テスト', status: '着手中')
    task3 = Task.create(title: 'statusによる失敗テスト(成功しない)', content: '失敗テスト', status: '完了')
    @tasks = Task.search('成功', '着手中')
    # binding.pry
    expect(@tasks).to include task1
    expect(@tasks).not_to include task2
    expect(@tasks).not_to include task3
  end
end