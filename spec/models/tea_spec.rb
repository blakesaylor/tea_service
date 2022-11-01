require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:temperature_c) }
    it { should validate_presence_of(:brew_time_sec) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:temperature_c).is_a?(Integer) }
    it { should validate_numericality_of(:brew_time_sec).is_a?(Integer) }
    it { should validate_numericality_of(:price).is_a?(Float) }
  end

  describe 'relationships' do
    it { should have_many(:subscription_teas) }
    it { should have_many(:subscriptions).through(:subscription_teas) }
  end

  before :each do

  end

  describe 'class methods' do

  end

  describe 'instance methods' do

  end
end
