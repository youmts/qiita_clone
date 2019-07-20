require "rails_helper"

RSpec.describe "Likes", type: :system, js_headless: true do
  it "「いいね」できること" do
    article = create(:article)
    sign_in user = create(:user)

    visit article_path(article)

    expect {
      Capybara.exact = true
      click_link "いいね"
      # wait ajax complete
      # FIXME not_to have_content("いいね")
      expect(page).to have_content("いいね済み")
    }.to change(article.get_likes, :size).by(1)
  end

  it "「いいね」を解除できること" do
    article = create(:article)
    sign_in user = create(:user)
    user.likes article

    visit article_path(article)

    expect {
      Capybara.exact = true
      click_link "いいね済み"
      # wait ajax complete
      expect(page).not_to have_content("いいね済み")
    }.to change(article.get_likes, :size).by(-1)
  end
end