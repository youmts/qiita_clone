class Article < ApplicationRecord
  extend Enumerize

  validates :title, presence: true
  validates :body, presence: true
  enumerize :status, in: [:draft, :open], default: :draft, scope: :shallow
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  acts_as_taggable
  acts_as_votable

  default_scope { includes(:user) }

  scope :top, -> { order(updated_at: :desc) }
end
