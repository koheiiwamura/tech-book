class Book < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :books
  acts_as_taggable
  mount_uploader :image, ImageUploader
end
