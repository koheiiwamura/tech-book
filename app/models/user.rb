class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:username]

  #usernameを必須とする
  validates_uniqueness_of :username
  validates_presence_of :username
  # has_many :books
  has_many :likes
  has_one :address
  # has_many :order
  has_many :orders_of_seller, :class_name => 'order', :foreign_key => 'seller_id'
  has_many :orders_of_buyer, :class_name => 'order', :foreign_key => 'buyer_id'
  has_many :books_of_seller, :through => :orders_of_seller, :source => 'book'
  has_many :books_of_buyer, :through => :orders_of_buyer, :source => 'book'
  has_many :like_books, through: :likes, source: :book
  mount_uploader :avatar, ImageUploader

  #usernameを利用してログインするようにオーバーライド
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      #認証の条件式を変更する
      where(conditions).where(["username = :value", { :value => username }]).first
    else
      where(conditions).first
    end
  end

  #emailを不要とする
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
