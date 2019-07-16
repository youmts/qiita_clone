require "rails_helper"

RSpec.describe "Tags", :type => :system, js_headless: true do
  it "タグはログインしていなくても参照できること" do
    create(:user, tag_list: ["tag_a", "tag_b"])

    visit tags_path

    expect(page).to have_content"tag_a"
    expect(page).to have_content"tag_b"
  end

  it "タグをフォローできること" do
    Capybara.exact = true

    create(:article, tag_list: ["tag"])
    sign_in user = create(:user)

    visit tags_path
    expect {
      click_button "フォロー"
      # wait ajax complete
      expect(page).to have_button("フォロー解除")
      expect(page).to have_no_button("フォロー")
    }.to change { user.reload.tag_list }.from([]).to(["tag"])
  end

  it "タグをフォロー解除できること" do
    Capybara.exact = true

    sign_in user = create(:user, tag_list: ["tag"])

    visit tags_path
    expect {
      click_button "フォロー解除"
      # wait ajax complete
      expect(page).to have_button("フォロー")
      expect(page).to have_no_button("フォロー解除")
    }.to change { user.reload.tag_list }.from(["tag"]).to([])
  end
end