class Book < ActiveRecord::Base
  belongs_to :user
  has_many :likes, dependent: :destroy
  acts_as_taggable_on :tags
  acts_as_taggable
  mount_uploader :image, ImageUploader

  def total_price(book)
    if book.price && book.postage
      book.price + book.postage
    end
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
