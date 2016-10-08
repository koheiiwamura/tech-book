class Bank < ActiveRecord::Base
  belongs_to :user

  validates :bank_name, presence: true
  validates :branch_name, presence: true
  validates :account_type, presence: true
  validates :number, presence: true
  validates :holder_name, presence: true
end
