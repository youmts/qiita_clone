class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  belongs_to :user

  default_scope { includes(:user) }

  scope :top, -> { order(updated_at: :desc) }
  scope :search, -> (text) {
    where("title like '%'||?||'%' or body like '%'||?||'%'", text, text)
  }
end
