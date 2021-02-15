class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #:confirmable

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user
  has_many :favorites, dependent: :destroy

  attachment :profile_image

  has_many :active_relationships, class_name: 'Relationship', foreign_key: :followed_id
  has_many :follows, through: :active_relationships, source: :follower

  has_many :passive_relationships, class_name: 'Relationship', foreign_key: :follower_id
  has_many :followers, through: :passive_relationships, source: :followed

  def followed_by?(user)
    passive_relationships.find_by(followed_id: user.id).present?
  end
end