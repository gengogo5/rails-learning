require 'rails_helper'

describe 'タスク管理機能', type: :system do
  describe '一覧表示機能' do
    before do
      # ユーザAを作成
      user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
      # ユーザAが作成したタスクを準備
      # タスクがDBに登録されるので変数化不要
      FactoryBot.create(:task, name: '最初のタスク', user: user_a)

    end
    context 'ユーザーAがログインしているとき' do
      before do
        # ユーザAでログインする
        visit login_path
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ユーザAが作成したタスクが表示される' do
        # 作成済みタスクの名称が画面表示されることを確認
        expect(page).to have_content '最初のタスク'
      end
    end
  end
end
