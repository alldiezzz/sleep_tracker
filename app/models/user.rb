class User < ApplicationRecord
  has_many :sleep_sessions, dependent: :destroy
  has_many :followed_users, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy
  has_many :followed, through: :followed_users
  has_many :followers, foreign_key: :followed_id, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :followers
end
