require 'rails_helper'

RSpec.describe User, type: :model do
  it 'nameが空ならバリデーションが通らない' do
    user = User.create(name: '', email: 'test@t.com', password: 'test', admin: false)
    expect(user).not_to be_valid
  end

  it 'nameが30文字より長いバリデーションが通らない' do
    user = User.create(name: "t"*31, email: 'test@t.com', password: 'test', admin: false)
    expect(user).not_to be_valid
  end

  it 'emailが空ならバリデーションが通らない' do
    user = User.create(name: 'test', email: '', password: 'test', admin: false)
    expect(user).not_to be_valid
  end

  it 'emailが255文字より長いとバリデーションが通らない' do
    user = User.create(name: 'test', email: "t"*256, password: 'test', admin: false)
    expect(user).not_to be_valid
  end

  it 'すでに登録されたemailはバリデーションが通らない' do
    user1 = User.create(name: 'test1', email: 'test@t.com', password: 'test1', admin: false)
    user2 = User.create(name: 'test2', email: 'test@t.com', password: 'test2', admin: false)
    expect(user2).not_to be_valid
  end

  it 'emailは"○○@△△.□□"の形式でないとバリデーションが通らない' do
    user = User.create(name: 'test', email: 'test', password: 'test', admin: false)
    expect(user).not_to be_valid
  end

  it 'passwordが空ならバリデーションが通らない' do
    user = User.create(name: 'test', email: 'test@t.com', password: '', admin: false)
    expect(user).not_to be_valid
  end
  
  it 'passwordが4文字未満だとバリデーションが通らない' do
    user = User.create(name: 'test', email: 'test@t.com', password: 't'*3, admin: false)
    expect(user).not_to be_valid
  end
  
  it 'name, email, passwordに内容が記載されていればバリデーションが通る(adminはdefaultでfalse)' do
    user = User.create(name: 'test', email: 'test@t.com', password: 'test')
    expect(user).to be_valid
  end
end
