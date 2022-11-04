require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:second_user)
  end
  describe 'ユーザー作成のテスト' do
    context 'ユーザーがログインせずにタスク一覧画面へ飛べない' do
      it 'タスク一覧画面に飛ぼうとしたとき、ログイン画面に遷移すること' do
        visit tasks_path
        expect(page).to have_content "Log in"
      end
    end
    context 'ユーザーを新規作成した場合' do
      it '新規登録できる' do
        visit new_user_path
        fill_in 'user[name]', with: "test"
        fill_in 'user[email]', with: "test@email.com"
        fill_in 'user[password]', with: "testtest"
        fill_in 'user[password_confirmation]', with: "testtest"
        click_on 'Create my account'
        expect(page).to have_content "testのページ"
      end
    end
  end
  describe 'セッション機能のテスト' do
    context 'セッション機能が問題ないかを確認' do
      it 'ログインができる。また、ログイン後にユーザー詳細ページに飛んでいる' do
        visit new_session_path
        fill_in 'session[email]', with: @user.email
        fill_in 'session[password]', with: @user.password
        click_on "Log in"
        expect(page).to have_content "ユーザー１のページ"
      end
      it '他人の詳細ページに飛ぼうとするとタスク一覧へ飛ぶ' do
        visit new_session_path
        fill_in 'session[email]', with: @user.email
        fill_in 'session[password]', with: @user.password
        click_on "Log in"
        visit user_path(@second_user)
        expect(page).to have_content "タスク一覧"
      end
      it 'ログアウトができる' do
        visit new_session_path
        fill_in 'session[email]', with: @user.email
        fill_in 'session[password]', with: @user.password
        click_on "Log in"
        click_on 'ログアウト'
        expect(page).to have_content "ログアウトしました"
      end
    end
    describe '管理者のテスト' do
      context '管理者機能に問題がないか確認' do
        it '管理ユーザは管理画面にアクセスできること' do
          visit new_session_path
          fill_in 'session[email]', with: @user.email
          fill_in 'session[password]', with: @user.password
          click_on "Log in"
          visit admin_users_path
          expect(page).to have_content "管理者画面"
        end
        it '一般ユーザは管理画面にアクセスできないこと' do
          visit new_session_path
          fill_in 'session[email]', with: @second_user.email
          fill_in 'session[password]', with: @second_user.password
          click_on "Log in"
          visit admin_users_path
          expect(page).to have_content "権限がありません"
        end
        it '管理ユーザはユーザの新規登録ができること' do
          visit new_session_path
          fill_in 'session[email]', with: @user.email
          fill_in 'session[password]', with: @user.password
          click_on "Log in"
          visit new_admin_user_path
          fill_in 'user[name]', with: "test"
          fill_in 'user[email]', with: "test@email.com"
          fill_in 'user[password]', with: "testtest"
          fill_in 'user[password_confirmation]', with: "testtest"
          select '一般ユーザー', from: 'user_admin'
          click_on "登録"
          expect(page).to have_content "ユーザーを作成しました！"
        end
        it '管理ユーザはユーザの詳細画面にアクセスできること' do
          visit new_session_path
          fill_in 'session[email]', with: @user.email
          fill_in 'session[password]', with: @user.password
          click_on "Log in"
          visit admin_users_path
          visit admin_user_path(@second_user.id)
          expect(page).to have_content "ユーザー詳細画面"
        end
        it '管理ユーザはユーザの編集画面からユーザを編集できること' do
          visit new_session_path
          fill_in 'session[email]', with: @user.email
          fill_in 'session[password]', with: @user.password
          click_on "Log in"
          visit admin_users_path
          visit edit_admin_user_path(@second_user.id)
          fill_in 'user[name]', with: "testtest"
          fill_in 'user[email]', with: "testtest@email.com"
          fill_in 'user[password]', with: "testtest"
          fill_in 'user[password_confirmation]', with: "testtest"
          select '管理者ユーザー', from: 'user_admin'
          click_on "更新する"
          expect(page).to have_content "testtest"
        end
        it '管理ユーザはユーザの削除をできること' do
          visit new_session_path
          fill_in 'session[email]', with: @user.email
          fill_in 'session[password]', with: @user.password
          click_on "Log in"
          visit admin_users_path
          click_on 'ユーザーを削除する', match: :first
          expect(page.accept_confirm).to eq "本当に削除していいですか？"
          expect(page).not_to have_content "ユーザー２"
        end
      end
    end
  end
end