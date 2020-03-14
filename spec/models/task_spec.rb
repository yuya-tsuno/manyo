require 'rails_helper'

RSpec.describe Task, type: :model do

  before(:each) do
    @user = User.create(name: 'test', email: 'test@t.com', password: 'test', admin: false)
  end

  it 'titleが空ならバリデーションが通らない' do
    task = Task.new(title: '', content: '失敗テスト', user_id: @user.id)
    expect(task).not_to be_valid
  end

  it 'contentが空ならバリデーションが通らない' do
    task = Task.new(title: '失敗テスト', content: '', user_id: @user.id)
    expect(task).not_to be_valid
  end

  it 'titleとcontentに内容が記載されていればバリデーションが通る' do
    task = Task.create(title: '成功テスト', content: '成功テスト', user_id: @user.id)
    expect(task).to be_valid
  end

  it '検索に入力された文字を含むtitleのみを取得する' do
    task1 = Task.create(title: '成功テスト', content: '成功テスト', status: 1, user_id: @user.id)
    task2 = Task.create(title: 'titleによる失敗テスト', content: '失敗テスト', status: 1, user_id: @user.id)
    task3 = Task.create(title: 'statusによる失敗テスト(成功しない)', content: '失敗テスト', status: 2, user_id: @user.id)
    @tasks = Task.search('成功', 1, @user.id)
    expect(@tasks).to include task1
    expect(@tasks).not_to include task2
    expect(@tasks).not_to include task3
  end
end