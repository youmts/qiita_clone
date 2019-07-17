class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article, counter_cache: true

  after_create -> {ArticlesMailer.with(comment: self).create_comment_email.deliver_later}

  validates :body, presence: true

  default_scope { includes(:user) }
end
