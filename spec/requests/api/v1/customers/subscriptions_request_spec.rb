require 'rails_helper'

describe "Customer Subscriptions" do
  it 'Can return a list of all active and cancelled subscriptions for a customer' do
    create(:customer)
    create_list(:tea, 3)
    5.times do 
      create(:subscription, customer_id: Customer.first.id)
    end
    10.times do
      create(:subscription_tea, subscription_id: Subscription.ids.sample, tea_id: Tea.ids.sample)
    end

    get api_v1_customer_subscriptions_path(Customer.first)
    
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body).to be_a Hash
    expect(response_body.keys.count).to eq 1
    expect(response_body.keys).to eq [:data]

    expect(response_body[:data]).to be_a Hash
    expect(response_body[:data].keys.count).to eq 3
    expect(response_body[:data].keys).to include(:id, :type, :attributes)

    expect(response_body[:data][:id]).to be_a String
    expect(response_body[:data][:id]).to eq Customer.first.id.to_s

    expect(response_body[:data][:type]).to be_a String
    expect(response_body[:data][:type]).to eq 'customer_subscriptions'

    expect(response_body[:data][:attributes]).to be_a Hash
    expect(response_body[:data][:attributes].keys.count).to eq 1
    expect(response_body[:data][:attributes].keys).to eq [:subscriptions]

    expect(response_body[:data][:attributes][:subscriptions].count).to eq 5
    expect(response_body[:data][:attributes][:subscriptions]).to be_a Array

    response_body[:data][:attributes][:subscriptions].each do |subscription|
      expect(subscription).to be_a Hash
      expect(subscription.keys.count).to eq 7
      expect(subscription.keys).to include(:id, :name, :status, :frequency, :customer_id, :created_at, :updated_at)

      test_subscription = Subscription.find(subscription[:id])

      expect(subscription[:id]).to be_a Integer
      expect(subscription[:id].in?(Subscription.ids)).to eq true

      expect(subscription[:name]).to be_a String
      expect(subscription[:name]).to eq test_subscription.name

      expect(subscription[:status]).to be_a String
      expect(subscription[:status]).to eq test_subscription.status

      expect(subscription[:frequency]).to be_a String
      expect(subscription[:frequency]).to eq test_subscription.frequency

      expect(subscription[:customer_id]).to be_a Integer
      expect(subscription[:customer_id]).to eq test_subscription.customer_id

      expect(subscription[:created_at]).to be_a String

      expect(subscription[:updated_at]).to be_a String
    end
  end

  it 'Returns a 404 if a Customer with a specified ID does not exist' do
    get api_v1_customer_subscriptions_path(123109812230)
    
    expect(response).to_not be_successful
    expect(response.status).to eq 404

    response_body = JSON.parse(response.body, symbolize_names: true)

    expect(response_body).to be_a Hash
    expect(response_body.keys.count).to eq 1
    expect(response_body.keys).to eq [:description]
    
    expect(response_body[:description]).to be_a String
    expect(response_body[:description]).to eq 'Error: No customer found with that ID'
  end
end
