class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  belongs_to :user

  scope :top, -> (count) { order(updated_at: :desc).limit(count) }
  scope :search, -> (text) {
    where("title like '%'||?||'%' or body like '%'||?||'%'", text, text)
  }
end
