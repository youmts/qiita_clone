class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article

  after_create -> {ArticlesMailer.with(comment: self).create_comment_email.deliver_later}

  default_scope { includes(:user) }
end
