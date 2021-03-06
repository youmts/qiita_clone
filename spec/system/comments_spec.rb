require "rails_helper"

RSpec.describe "Comments", type: :system, js_headless: true do
  COMMENT_BODY = "form.new_comment #comment_body"

  it "コメントできること" do
    article = create(:article)
    sign_in create(:user)

    visit article_path(article)

    expect(page).not_to have_content("新しいコメント")
    find(COMMENT_BODY).fill_in with: "新しいコメント"

    expect {
      click_button "投稿"
      # wait ajax complete
      expect(page).to have_content("新しいコメント")
    }.to \
      change(Comment, :count).by(1).and \
      change(ActionMailer::Base.deliveries, :count).by(1)

    mail = ActionMailer::Base.deliveries.last
    expect(mail.body.raw_source).to include "新しいコメント"
  end

  it "コメントを削除できること" do
    comment = create(:comment, body: "削除するコメント")
    sign_in comment.user

    visit article_path(comment.article)
    expect(page).to have_content("削除するコメント")
    selector = "a[data-method=\"delete\"][href=\"#{article_comment_path(comment.article, comment)}\""
    expect(page).to have_selector(selector, count: 1)

    delete_link = find(selector)
    expect {
      accept_alert { delete_link.click }
      # wait ajax complete
      expect(page).not_to have_content("削除するコメント")
    }.to change(Comment, :count).by(-1)
  end

  it "コメントが空の場合エラーになること" do
    article = create(:article)
    sign_in article.user
    
    visit article_path(article)

    find(COMMENT_BODY).fill_in with: ""

    expect {
      click_button "投稿"
      # wait ajax complete
      expect(page).to have_content("コメントの投稿に失敗しました")
    }.to change(Comment, :count).by(0).and \
      change(ActionMailer::Base.deliveries, :count).by(0)
  end
end