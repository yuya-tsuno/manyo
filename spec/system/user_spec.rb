require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  before do
    @user1 = FactoryBot.create(:user, name: 'user1')
    @user2 = FactoryBot.create(:user, name: 'user2')
  end

  def log_in_as_user1
    visit new_session_path
    fill_in "Email", with: @user1.email
    fill_in "Password", with: @user1.password
    click_on 'Log in'
  end
  
  describe 'サインイン（ユーザー登録）画面' do

    context 'ユーザー登録された場合' do
      it 'ログインも同時に行われる' do
        visit new_user_path
        fill_in "名前", with: 'user3'
        fill_in "メールアドレス", with: 'user3@t.t'
        fill_in "パスワード", with: 'user3'
        fill_in "確認用パスワード", with: 'user3'
        click_on '登録する'
        expect(page).to have_content 'User was successfully created and logged in.'
        expect(page).to have_content 'User:user3の詳細'
      end
    end
    
    context 'ログイン時に新規ユーザー登録画面にアクセスした場合' do
      it 'トップページに移動' do
        log_in_as_user1
        visit new_user_path
        expect(page).to have_content 'ログアウトしてください'
        expect(page).to have_content 'user1のタスク一覧'
      end
    end

  end

  describe 'プロフィール（ユーザー詳細）画面' do
    context '自分（current_user）以外のユーザのマイページ（userのshow画面）にアクセスした場合' do
      it 'トップページに移動' do
        log_in_as_user1
        visit user_path(@user2.id)
        expect(page).to have_content 'あなたのアカウントではアクセス権限がありません'
        expect(page).to have_content 'user1のタスク一覧'
      end
    end
  end

end