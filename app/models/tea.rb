class Tea < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :temperature_c
  validates_presence_of :brew_time_sec
  validates_presence_of :price
  validates_numericality_of :temperature_c, only_integer: true
  validates_numericality_of :brew_time_sec, only_integer: true
  validates_numericality_of :price, only_float: true

  has_many :subscription_teas
  has_many :subscriptions, through: :subscription_teas
end
