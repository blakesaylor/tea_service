require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:address) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe 'relationships' do
    it { should have_many :subscriptions }
    it { should have_many(:teas).through(:subscriptions) }
  end

  before :each do
    @blake = Customer.create!( first_name: 'blake',
                      last_name: 'saylor',
                      email: 'BLAKESaylor@gmail.com',
                      address: '123 Fake Street')
  end

  describe 'class methods' do
    
  end

  describe 'instance methods' do
    it 'can downcase an email when input' do
      expect(@blake.email).to eq "blakesaylor@gmail.com"
    end
  end
end
