require "rails_helper"

RSpec.describe "Home", :type => :system do
  example "トレンドが表示できること" do
    visit root_path
    expect(page).to have_current_path root_path
  end

  example "タグフィードが表示できること" do
    visit tag_feed_path
    expect(page).to have_current_path tag_feed_path
  end
end
