class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  belongs_to :user

  scope :top, -> (count) { order(updated_at: :desc).limit(count) }
end
