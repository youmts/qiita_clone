class ArticlesMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comments_mailer.create.subject
  #
  def create_comment_email
    @comment = params[:comment]

    mail to: @comment.article.user.email, subject: 'あなたの記事にコメントが追加されました！'
  end
end
