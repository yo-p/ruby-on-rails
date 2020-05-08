require 'rails_helper'

describe 'タスク管理機能', type: :system do
    let(:user_a) {FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')}
    let(:user_b) {FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
    let!(:task_a) {FactoryBot.create(:task, name: '最初のタスク', user: user_a)}

    before do
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
        visit login_path
        fill_in 'メールアドレス', with: login_user.email
        fill_in 'パスワード', with: login_user.password
        click_button 'ログインする'
    end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしている時' do 
      let(:login_user) { user_a }
      
      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク'
      end
  end

    context 'ユーザーBがログインしている時' do
      let(:login_user) { user_b }
  
      it 'ユーザーAが作成したタスクが表示されない' do 
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしている時' do
      let(:login_user) {user_a}

      before do
        visit task_path(task_a)
      end
      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク'
      end
    end
  end

  describe '新規作成機能' do 
    let(:login_user) {user_a}

    before do
      visit new_task_path
      fill_in 'task[name]', with: task_name
      click_button '登録する'
    end

    context '新規作成画面で名称を入力された時' do
      let(:task_name) {'新規作成テストを書く'}

      it '正常に投稿される' do 
        expect(page).to have_selector '.alert-success', text: '新規作成テストを書く'
      end
    end

    context '新規作成画面で入力されなかった時' do
      let(:task_name) {''}

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content 'Nameを入力してください'
        end
      end
    end
  end
end
