class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :nullify
  acts_as_taggable
  acts_as_voter

  def articles_tags_count
    self.articles.joins(taggings: :tag).group('tags.name').count
  end
end
