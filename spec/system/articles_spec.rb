require "rails_helper"

RSpec.describe "Articles", :type => :system, js_headless: true do
  let!(:tag1) { create(:tag) }
  let!(:tag2) {create(:tag) }

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
    select tag1.name, from: "article_tag_list"

    expect {
      click_button "保存"
    }.to change(Article, :count).by(1)

    expect(page).to have_current_path article_path(Article.last)
    expect(Article.last.tag_list).to eq [tag1.name]
  end

  it "記事が編集できること" do
    article = create(:article)
    sign_in article.user

    visit articles_path
    click_link "編集"

    click_button "保存"

    expect(page).to have_current_path article_path(article)
  end

  it "記事が削除できること" do
    article = create(:article)
    sign_in article.user

    visit articles_path

    expect {
      accept_alert {
        click_link "削除"
      }

      expect(page).to have_current_path articles_path
    }.to change(Article, :count).by(-1)
  end

  context "ドラフト状態の記事の場合" do
    before do
      @article = create(:article, status: :draft, title: "draft")
    end

    it "記事が記事一覧で参照できないこと" do
      visit articles_path
      expect(page).not_to have_content "draft"
    end

    it "記事がユーザページで参照できないこと" do
      visit user_path(@article.user)
      expect(page).not_to have_content "draft"
    end

    it "記事がタグページで参照できないこと" do
      visit tag_path(@article.tags.first)
      expect(page).not_to have_content "draft"
    end

    it "作成したユーザのドラフトページで参照できること" do
      sign_in @article.user
      visit drafts_articles_path

      expect(page).to have_content "draft"
    end
  end
end
