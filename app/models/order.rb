class Order < ActiveRecord::Base
  belongs_to :seller, :class_name => 'User'
  belongs_to :buyer, :class_name => 'User'
  belongs_to :book
  belongs_to :order_detail

  validates :book_id, uniqueness: true, uniqueness: { scope: :buyer_id }
  validates :accept_booking, acceptance: true
end
