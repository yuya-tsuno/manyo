require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  before do
    user = FactoryBot.create(:user, name: 'test1_user', email: 't1@t.t', password: 'tttt', admin: false)
    task = FactoryBot.create(:task, title: 'task', content: 'task', limit: '2020-02-01', priority: 1, user: user)
    
    def log_in_as_test1
      visit new_session_path
      fill_in "Email", with: 't1@t.t'
      fill_in "Password", with: 'tttt'
      click_on 'Log in'
    end
    log_in_as_test1
  end
  
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること' do
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        new_task = FactoryBot.create(:task, title: 'new_task', content: 'new_task', limit: '2020-02-01', priority: 1, user: user)
        visit tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
      end

      it 'タスクが終了期限の早い順に並んでいること' do
        new_task = FactoryBot.create(:task, title: 'new_task', content: 'task_content', limit: '2020-03-01', user: user)
        new_task = FactoryBot.create(:task, title: 'old_task', content: 'task_content', limit: '2020-01-01', user: user)
        visit tasks_path(limit_sort_expired: "true")
        sleep 0.1
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'old_task'
        expect(task_list[1]).to have_content 'task'
        expect(task_list[2]).to have_content 'new_task'
      end

      it 'タスクが優先度の高い順に並んでいること' do
        new_task = FactoryBot.create(:task, title: 'important_task', content: 'task_content', limit: '2020-03-01', priority: 0, user: user)
        new_task = FactoryBot.create(:task, title: 'not_important_task', content: 'task_content', limit: '2020-01-01',priority: 2, user: user)
        visit tasks_path(priority_sort_expired: "true")
        sleep 0.1
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'important_task'
        expect(task_list[1]).to have_content 'task'
        expect(task_list[2]).to have_content 'not_important_task'
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
        visit new_task_path
        task = Task.new(title: "fdfdsfasfsda", content: "nfviwhsringiuh", user: user)
        fill_in "task_title", with: task.title
        fill_in "task_content", with: task.content
        click_on 'task_submit'
        expect(page).to have_content task.title
        expect(page).to have_content task.content
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        tasks = Task.all
        tasks.each do |task|
          visit task_path(task.id)
          expect(page).to have_content task.title
          expect(page).to have_content task.content
        end
      end
    end
  end

end