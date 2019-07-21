class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_taggable
  acts_as_votable

  default_scope { includes(:user) }

  scope :top, -> { order(updated_at: :desc) }
end
