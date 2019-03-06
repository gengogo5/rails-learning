require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }

    before do
      # ユーザAが作成したタスクを準備
      # タスクがDBに登録されるので変数化不要
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)
      # ユーザAでログインする
      visit login_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_button 'ログインする'

    end

    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }
      it 'ユーザAが作成したタスクが表示される' do
        # 作成済みタスクの名称が画面表示されることを確認
        expect(page).to have_content '最初のタスク'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        # ユーザーAが作成したタスク名称が画面表示されていないこと
        expect(page).to have_no_content '最初のタスク'
      end
    end
  end
end
