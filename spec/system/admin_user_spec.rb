require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user1 = FactoryBot.create(:user, name: 'user2', admin: false)
    @user2 = FactoryBot.create(:user, name: 'user1', admin: true)
    @admin_user = FactoryBot.create(:user, name: 'admin_user', admin: true)

    task1 = FactoryBot.create(:task, title: 'task1', limit: '2020-03-01', user: @user1)
    task2 = FactoryBot.create(:task, title: 'task2', limit: '2020-01-01', user: @user1)
  end

  def log_in_as_admin_user
    visit new_session_path
    fill_in "Email", with: @admin_user.email
    fill_in "Password", with: @admin_user.password
    click_on 'Log in'
  end
  
  describe 'ユーザー一覧画面' do
    it 'ユーザが持っているタスクの数を表示する' do
      @n = rand(1..99)
      @n.times do
        task = FactoryBot.create(:task, user: @user2)
      end
      
      log_in_as_admin_user
      visit admin_users_path
      expect(page).to have_content 2
      expect(page).to have_content @n
    end    
  end
  
  describe 'ユーザー詳細管理画面' do
    it 'ユーザが作成したタスクの一覧を表示' do
      log_in_as_admin_user
      visit admin_user_path(@user1.id)
      sleep 0.1
      expect(page).to have_content 'task1'
      expect(page).to have_content 'task2'
    end
  end
end