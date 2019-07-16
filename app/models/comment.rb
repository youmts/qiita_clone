class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  
  default_scope { includes(:user) }
end
