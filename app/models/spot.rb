class Spot < ApplicationRecord
  belongs_to :post
  has_many :notifications, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
