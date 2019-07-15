class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  belongs_to :user
  acts_as_taggable

  default_scope { includes(:user) }

  scope :top, -> { order(updated_at: :desc) }
  scope :search, -> (text) {
    where("title like '%'||?||'%' or body like '%'||?||'%'", text, text)
  }
  scope :favorite, -> (user) {
    tagged_with(user.tag_list, :any => true) if user.present?
  }
end
