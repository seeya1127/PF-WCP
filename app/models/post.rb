class Post < ApplicationRecord
  has_many :comments
  has_many :favorites
  has_many :tags
  belongs_to :user

  attachment :post_image
end