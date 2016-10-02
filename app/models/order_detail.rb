class OrderDetail < ActiveRecord::Base
  has_one :order
end
