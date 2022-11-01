require 'rails_helper'

RSpec.describe SubscriptionTea, type: :model do
  describe 'validations' do
    
  end

  describe 'relationships' do
    it { should belong_to :subscription }
    it { should belong_to :tea }
  end

  before :each do

  end

  describe 'class methods' do

  end

  describe 'instance methods' do

  end
end
