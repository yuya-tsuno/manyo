require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user, name: 'test', email: 't@t.t', password: 'tttt', admin: false)
  end
  
  describe 'ユーザー一覧画面' do
    context 'ユーザー登録された場合ユーザを削除した場合' do
      it 'そのユーザが抱えているタスクを削除する' do
      end
    end
    
    it 'ユーザが持っているタスクの数を表示する' do
    end
  end

  describe 'ユーザー詳細管理画面' do
    it 'ユーザが作成したタスクの一覧を表示' do
    end
  end

end