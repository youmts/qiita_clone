require "rails_helper"

RSpec.describe "Articles", :type => :system do
  it "記事はログインしていなくても参照できること" do
    article = create(:article)

    visit article_path(article)

    expect(page).to have_current_path article_path(article)
  end

  it "記事は作成者でなくても参照できること" do
    article = create(:article)

    # sign in other user
    sign_in user = create(:user)
    expect(user).not_to be article.user

    visit article_path(article)

    expect(page).to have_current_path article_path(article)
  end

  it "記事が作成できること" do
    sign_in create(:user)

    visit articles_path

    click_link "新規記事"
    expect(page).to have_current_path new_article_path

    fill_in "タイトル", with: "私の記事"
    fill_in "本文", with: "本文"

    expect {
      click_button "公開"
    }.to change(Article, :count).by(1)

    expect(page).to have_current_path article_path(Article.last)
  end

  it "記事が編集できること" do
    article = create(:article)
    sign_in article.user

    visit articles_path
    click_link "編集"

    click_button "公開"

    expect(page).to have_current_path article_path(article)
  end

  it "記事が削除できること" do
    article = create(:article)
    sign_in article.user

    visit articles_path

    expect {
      click_link "削除"
    }.to change(Article, :count).by(-1)

    expect(page).to have_current_path articles_path
  end
end
