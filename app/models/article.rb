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
    # FIXME 重い処理なのでバッチで計算させるようにすべき

    find_by_sql([<<-'SQL', duration_begin: Time.current.ago(duration), limit: limit])
      SELECT articles.*
      FROM articles
      LEFT OUTER JOIN (
        SELECT votable_id, row_number() over (ORDER BY count(*) DESC, votable_id) row_number
        FROM votes
        WHERE votable_type = 'Article'
          AND created_at >= :duration_begin
        GROUP BY votable_id
      ) vote_count
      ON articles.id = vote_count.votable_id
      ORDER BY vote_count.row_number
      LIMIT :limit
    SQL
  end
end
