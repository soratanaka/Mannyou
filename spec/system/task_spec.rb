require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        task = FactoryBot.create(:task, name: '名前', content: 'コンテント')
        visit tasks_path
        expect(page).to have_content '名前'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      task = FactoryBot.create(:task, name: 'test_name', content: 'コンテント')
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'test_name'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, name: '名前', content: 'コンテント')
        visit task_path(task.id)
        expect(page).to have_content 'コンテント'
      end
    end
  end
end