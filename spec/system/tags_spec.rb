require "rails_helper"

RSpec.describe "Tags", :type => :system do
  it "タグはログインしていなくても参照できること" do
    user = create(:user, tag_list: ["tag_a", "tag_b"])

    visit tags_path

    expect(page).to have_content"tag_a"
    expect(page).to have_content"tag_b"
  end
end