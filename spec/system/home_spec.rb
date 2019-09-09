require "rails_helper"

RSpec.describe "Home", :type => :system do
  context "未ログインのとき" do
    example "トレンドが表示できること" do
      visit root_path
      expect(page).to have_current_path root_path
    end

    example "タグフィードはリダイレクトすること" do
      visit tag_feed_path
      expect(page).to have_current_path root_path
    end
  end

  context "ログイン済みのとき" do
    before do
      sign_in user = create(:user)
    end

    example "トレンドが表示できること" do
      visit root_path
      expect(page).to have_current_path root_path
    end

    example "タグフィードが表示できること" do
      visit tag_feed_path
      expect(page).to have_current_path tag_feed_path
    end
  end
end
