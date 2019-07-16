class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_taggable

  default_scope { includes(:user) }

  scope :top, -> { order(updated_at: :desc) }
  scope :search, -> (text) {
    tag = ActsAsTaggableOn::Tag.find_by_name(text)
    if tag.present?
      Article.tagged_with(tag.name)
    else
      like(text)
    end
  }
  scope :favorite, -> (user) {
    tagged_with(user.tag_list, :any => true) if user.present?
  }
  scope :like, -> (text) {
    where("title like '%'||?||'%' or body like '%'||?||'%'", text, text)
  }
end
