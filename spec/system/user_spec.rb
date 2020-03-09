require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  before do
    @user = FactoryBot.create(:user, id: 1, name: 'test1', email: 't1@t.t', password: 'tttt', admin: false)
    @user = FactoryBot.create(:user, id: 2, name: 'test2', email: 't2@t.t', password: 'tttt', admin: false)
  end

  def log_in_as_test1
    visit new_session_path
    fill_in "Email", with: 't1@t.t'
    fill_in "Password", with: 'tttt'
    click_on 'Log in'
  end
  
  describe 'サインイン（ユーザー登録）画面' do

    context 'ユーザー登録された場合' do
      it 'ログインも同時に行われる' do
        visit new_user_path
        fill_in "Name", with: 'test3'
        fill_in "Email", with: 'test3@t.t'
        fill_in "Password", with: 'tttt'
        fill_in "Password confirmation", with: 'tttt'
        click_on 'Create User'
        expect(page).to have_content 'User was successfully created and logged in.'
        expect(page).to have_content 'User:test3の詳細'
      end
    end
    
    context 'ログイン時に新規ユーザー登録画面にアクセスした場合' do
      it 'トップページに移動' do
        log_in_as_test1
        visit new_user_path
        expect(page).to have_content 'ログアウトしてください'
        expect(page).to have_content 'test1のタスク一覧'
      end
    end

  end

  describe 'プロフィール（ユーザー詳細）画面' do
    context '自分（current_user）以外のユーザのマイページ（userのshow画面）にアクセスした場合' do
      it 'トップページに移動' do
        log_in_as_test1
        visit user_path(2)
        expect(page).to have_content 'あなたのアカウントではアクセス権限がありません'
        expect(page).to have_content 'test1のタスク一覧'
      end
    end
  end

end