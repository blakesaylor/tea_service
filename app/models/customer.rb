class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_uniqueness_of :email, case_sensitive: false
  validates_presence_of :address
  before_save :downcase_email

  has_many :subscriptions
  has_many :teas, through: :subscriptions

  private

  def downcase_email
    email&.downcase!
  end
end
