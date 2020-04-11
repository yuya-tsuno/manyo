require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do

  before do
    @user1 = FactoryBot.create(:user, name: 'user2', admin: false)
    @user2 = FactoryBot.create(:user, name: 'user1', admin: true)
    @admin_user = FactoryBot.create(:user, name: 'admin_user', admin: true)

    task1 = FactoryBot.create(:task, title: 'task1', limit: '2020-03-01', user: @user1)
    task2 = FactoryBot.create(:task, title: 'task2', limit: '2020-01-01', user: @user1)

    label1 = FactoryBot.create(:label, name: 'label1')
    label2 = FactoryBot.create(:label, name: 'label2')

    labeling1 = FactoryBot.create(:labeling, task_id: task1.id, label_id: label1.id)
    labeling2 = FactoryBot.create(:labeling, task_id: task2.id, label_id: label2.id)
  end
  
  def login_as(user)
    visit new_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on 'Log in'
  end

  describe 'ラベル一覧画面' do
    context '管理者がラベルを作成した場合' do
      it '作成済みのタスクが表示されること' do
        login_as(@admin_user)
        visit admin_labels_path
        expect(page).to have_content 'label1'
        expect(page).to have_content 'label2'
      end
    end

    # context 'ユーザーが自分でラベルを作成した場合' do
    #   it '自身の作ったラベルのみ表示されること' do
    #     login_as(@user1)
    #     visit labels_path
    #     expect(page).to have_content 'label3'
    #     pending '+α課題、未実装'
    #   end
    # end
  end
    
  describe 'タスク一覧画面' do
    it 'タスク一覧画面で、ラベル検索ができること' do
      login_as(@admin_user)
      visit admin_tasks_path
      check 'label1'
      click_on('Search')
      sleep 0.1
      expect(page).to have_content 'label1'
    end
  end

  # describe 'タスク編集画面' do
  #   it 'ラベルの複数編集ができること' do
  #     click_on 
  #     click_on('Search')
  #     expect(page).to have_content 'label4'
  #     pending '+α課題、未実装'
  #   end
  # end
end