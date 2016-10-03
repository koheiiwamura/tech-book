class Order < ActiveRecord::Base
  belongs_to :seller, :class_name => 'User'
  belongs_to :buyer, :class_name => 'User'
  belongs_to :book
  # belongs_to :user
  belongs_to :order_detail
end
