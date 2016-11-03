class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :authentication_keys => [:username], omniauth_providers: [:facebook]

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: {minimum:8}, on: :create
  validates :password, length: {minimum:8}, on: :update, allow_blank: true
  validates :password_confirmation, length: {minimum:8}, on: :update, allow_blank: true
  has_one :bank
  has_one :address
  has_many :books
  has_many :likes
  has_many :comments
  has_many :orders_of_seller, :class_name => 'Order', :foreign_key => 'seller_id'
  has_many :orders_of_buyer, :class_name => 'Order', :foreign_key => 'buyer_id'
  has_many :books_of_seller, :through => :orders_of_seller, :source => 'book'
  has_many :books_of_buyer, :through => :orders_of_buyer, :source => 'book'
  has_many :like_books, through: :likes, source: :book
  mount_uploader :avatar, ImageUploader

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
      user.send_facebook_password
    end
    user
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def send_password_reset
    set_password_mailer
    UserMailer.password_reset(self).deliver_now
  end

  def send_facebook_password
    set_password_mailer
    UserMailer.facebook_password(self).deliver_now
  end


  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password, :password_confirmation].blank?
      params.delete(:password, :password_confirmation)
    end
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  private
  def set_password_mailer
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.save(validate: false)
  end

end
