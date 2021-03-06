require "rails_helper"

RSpec.describe "Users", :type => :system do
  it "サインアップできること" do
    visit new_user_registration_path

    fill_in "名前", with: "れいるず　太郎"
    fill_in "メールアドレス", with: "test@example.com"
    fill_in "パスワード", with: "password"
    fill_in "確認用パスワード", with: "password"

    expect {
      click_button "登録"
    }.to change(User, :count).by(1)

    expect(User.last.name).to eq "れいるず　太郎"

    expect(page).to have_current_path root_path
    expect(page).to have_content "アカウント登録が完了しました"
  end

  context "ユーザ登録済みのとき" do
    before do
      @user = create(:user, password: "password", password_confirmation: "password")
    end

    it "ログインできること" do
      visit new_user_session_path
      fill_in "メールアドレス", with: @user.email
      fill_in "パスワード", with: @user.password

      click_button "ログイン"

      expect(page).to have_content "ログインしました"
    end
  end
end