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
end