require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        task = FactoryBot.create(:task, name: '名前', content: 'コンテント', finish_on: '2022-10-30')
        visit tasks_path
        # expect(page).to have_content '名前'
        expect(page).to have_content '2022-10-30'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      task = FactoryBot.create(:task)
      task = FactoryBot.create(:second_task)
      task = FactoryBot.create(:task, name: 'test_name', content: 'コンテント')
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'test_name'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_name') 
        expect(task_list[0]).to have_content "test_name"
        expect(task_list[1]).to have_content "タスク２"
        expect(task_list[2]).to have_content "タスク１"
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

