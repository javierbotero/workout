class User < ApplicationRecord
  has_many :friendships, -> { where(confirmed: true) }, dependent: :destroy
  has_many :friends, through: :friendships
  has_many :pendings, -> { where(confirmed: false) }, class_name: 'Friendship', dependent: :destroy
  has_many :requests, -> { where(confirmed: false) }, class_name: 'Friendship',
                                                      foreign_key: 'friend_id',
                                                      dependent: :destroy
  has_many :votes, dependent: :destroy
  has_one_attached :avatar
  has_many :articles, foreign_key: 'author_id', dependent: :destroy
  validates :username, presence: true, uniqueness: true, length: { minimum: 1, maximum: 50 }
end
