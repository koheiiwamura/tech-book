class Like < ActiveRecord::Base
  belongs_to :book, :counter_cache => :likes_count
  belongs_to :user
end
