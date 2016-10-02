class Book < ActiveRecord::Base
  has_many :sellers, :through => :order
  has_many :buyers, :through => :order
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :order
  acts_as_taggable_on :tags
  acts_as_taggable
  mount_uploader :image, ImageUploader

  def total_price(book)
    if book.price && book.postage
      book.price + book.postage
    end
  end
  def price_tax(book)
    total_price(book)*0.08.round
  end
  def all_total_price(book)
    total_price(book) + price_tax(book)
  end
  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
