require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user1 = FactoryBot.create(:user, name: 'user2', admin: false)
    @user2 = FactoryBot.create(:user, name: 'user1', admin: true)
    @admin_user = FactoryBot.create(:user, name: 'admin_user', admin: true)

    task1 = FactoryBot.create(:task, title: 'task1', limit: '2020-03-01', user: @user1)
    task2 = FactoryBot.create(:task, title: 'task2', limit: '2020-01-01', user: @user1)
  end

  context 'ユーザー登録された場合ユーザを削除した場合' do
    it 'そのユーザが抱えているタスクを削除する' do
      @delete = User.destroy(@user1.id)
      expect(Task.where(user_id: @user1.id).count).to eq 0
    end
  end  
end
