class OrderDetail < ActiveRecord::Base
  has_one :order

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :street_address, presence: true
  validates :postal_code, presence: true
  validates :phone_number, presence: true
  validates :email, presence: true
end
