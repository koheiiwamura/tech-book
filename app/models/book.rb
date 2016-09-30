class Book < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :tags
  acts_as_taggable
  mount_uploader :image, ImageUploader

  def total_price(book)
    if book.price && book.postage
      book.price + book.postage
    end
  end
end
