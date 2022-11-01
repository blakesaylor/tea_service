class Subscription < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :status
  validates_presence_of :frequency

  enum status: { 'cancelled': 0, 'active': 1 }
  enum frequency: { 'monthly': 0, 'trimonthly': 1, 'bi-annual': 2, 'annual': 3 }

  belongs_to :customer
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas

end
