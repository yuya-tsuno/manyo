require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  # before do
  #   FactoryBot.create(:task, title: '付け加えた名前１')
  #   FactoryBot.create(:task, title: '付け加えた名前２')
  #   FactoryBot.create(:second_task, title: '付け加えた名前３', content: '付け加えたコンテント')
  # end

  # background do
  #   # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
  #   FactoryBot.create(:task)
  #   FactoryBot.create(:second_task)
  # end

  before do
    # 「タスク一覧画面」や「タスク詳細画面」などそれぞれのテストケースで、before内のコードが実行される
    # 各テストで使用するタスクを1件作成する
    # 作成したタスクオブジェクトを各テストケースで呼び出せるようにインスタンス変数に代入
    @task = FactoryBot.create(:task, title: 'task', content: 'task', limit: '2020-02-01', priority: 1)
  end
  
  describe 'タスク一覧画面' do
    context 'タスクを作成した場合' do
      # テストコードを it '~' do end ブロックの中に記載する
      it '作成済みのタスクが表示されること' do
        # タスク一覧ページに遷移
        visit admin_tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列がhave_contentされているか。（含まれているか。）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expect(page).to have_content 'task_title_failure'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end

    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        new_task = FactoryBot.create(:task, title: 'new_task')
        visit admin_tasks_path
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'new_task'
        expect(task_list[1]).to have_content 'task'
      end

      it 'タスクが終了期限の早い順に並んでいること' do
        new_task = FactoryBot.create(:task, title: 'new_task', content: 'task_content', limit: '2020-03-01')
        new_task = FactoryBot.create(:task, title: 'old_task', content: 'task_content', limit: '2020-01-01')
        visit admin_tasks_path(limit_sort_expired: "true")
        sleep 0.1
        task_list = all('.task_row') # タスク一覧を配列として取得するため、View側でidを振っておく
        expect(task_list[0]).to have_content 'old_task'
        expect(task_list[1]).to have_content 'task'
        expect(task_list[2]).to have_content 'new_task'
      end

      it 'タスクが優先度の高い順に並んでいること' do
        new_task = FactoryBot.create(:task, title: 'important_task', content: 'task_content', limit: '2020-03-01', priority: 0)
        new_task = FactoryBot.create(:task, title: 'not_important_task', content: 'task_content', limit: '2020-01-01',priority: 2)
        visit admin_tasks_path(priority_sort_expired: "true")
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
        # new_task_pathにvisitする（タスク登録ページに遷移する）
        visit new_task_path
        # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
        # タスクのタイトルと内容をそれぞれfill_in（入力）する
        task = Task.new(title: "fdfdsfasfsda", content: "nfviwhsringiuh")
        fill_in "task_title", with: task.title
        fill_in "task_content", with: task.content
        # 「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）
        click_on 'task_submit'
        # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する（タスクが登録されたらタスク詳細画面に遷移されるという前提）
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