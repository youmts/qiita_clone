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

  def self.trend(duration, limit)
    # FIXME とても重い処理なのでバッチで計算させるようにすべき

    articles_votes = all.map do |a|
      [a.id, a.get_likes
        .where("created_at >= :date", date: Time.current.ago(duration)).size]
    end

    ids = articles_votes.sort { |a, b| b[1] <=> a[1]}.map { |x| x[0] }.take(limit)

    Article.find(ids)
  end
end
