class User < ApplicationRecord
  has_many :friendships, -> { where(confirmed: true) }
  has_many :friends, through: :friendships
  has_many :pendings, -> { where(confirmed: false) }, class_name: 'Friendship'
  has_many :requests, -> { where(confirmed: false) }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :votes
  has_one_attached :avatar
end
