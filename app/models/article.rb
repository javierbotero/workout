class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :votes
  has_many :voters, through: :votes, source: :user
  has_and_belongs_to_many :categories
  validates :title, presence: true, length: { minimum: 1, maximum: 50 }
  validates :text, presence: true, length: { minimum: 100, maximun: 1000 }, uniqueness: true
  has_one_attached :main
  has_many_attached :photos

  def self.more_voted
    find_by(votes_count: Article.maximum('votes_count'))
  end
end
