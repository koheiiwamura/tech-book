class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :authentication_keys => [:username]

  #usernameを必須とする
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum:8}
  has_many :books
  has_many :likes
  has_many :comments
  has_one :address
  has_one :bank
  has_many :orders_of_seller, :class_name => 'Order', :foreign_key => 'seller_id'
  has_many :orders_of_buyer, :class_name => 'Order', :foreign_key => 'buyer_id'
  has_many :books_of_seller, :through => :orders_of_seller, :source => 'book'
  has_many :books_of_buyer, :through => :orders_of_buyer, :source => 'book'
  has_many :like_books, through: :likes, source: :book
  mount_uploader :avatar, ImageUploader
  devise :omniauthable, omniauth_providers: [:facebook]

def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
    end
  end
end

 def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    unless user
      user = User.create(
        uid:      auth.uid,
        provider: auth.provider,
        username: auth.info.name,
        email:    auth.info.email,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.save(validate: false)
    UserMailer.password_reset(self).deliver_now
  end

end
