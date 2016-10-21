class Book < ActiveRecord::Base
  has_one :seller, :through => :order
  has_one :buyer, :through => :order
  has_one :order
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 400 }
  validates :state, presence: true
  validates :price, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 100000 }
  validates :postage, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10000 }

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
