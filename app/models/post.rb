class Post < ApplicationRecord
  has_many :comments
  has_many :favorites
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps, dependent: :destroy
  belongs_to :user
  has_one :spot, dependent: :destroy
  accepts_nested_attributes_for :spot

  attachment :post_image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def save_tag(sent_tags)
   current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
   old_tags = current_tags - sent_tags
   new_tags = sent_tags - current_tags

   old_tags.each do |old|
     self.tags.delete Tag.find_by(tag_name: old)
   end

   new_tags.each do |new|
     new_post_tag = Tag.find_or_create_by(tag_name: new)
     self.tags << new_post_tag
   end
  end

  enum place: {
    お家: 0,
    お店: 1,
  }

end