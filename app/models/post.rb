class Post < ApplicationRecord
  has_many :comment
  has_many :favorite
  has_many :tag

  attachment :post_image
end