require 'rails_helper'

describe "Customer Subscriptions" do
  describe '#index' do
    describe 'Happy Path' do
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
    end
    
    describe 'Sad Path' do
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
  end
  
  describe '#create' do
    describe 'Happy Path' do
      it "Can create a new subscription"  do
        create(:customer)
        create_list(:tea, 3)

        input_body = {
          'customer_id': Customer.first.id,
          'name': Faker::Subscription.plan,
          'frequency': Faker::Number.between(from: 0, to: 3),
          'teas': [ Tea.first.id, Tea.third.id ]
        }

        post api_v1_customer_subscriptions_path(input_body)

        expect(response).to be_successful

        response_body = JSON.parse(response.body, symbolize_names: true)

        last_subscription = Subscription.last

        expect(response_body).to be_a Hash
        expect(response_body.keys.count).to eq 1
        expect(response_body.keys).to eq [ :data ]

        expect(response_body[:data]).to be_a Hash
        expect(response_body[:data].keys.count).to eq 3
        expect(response_body[:data].keys).to include(:id, :type, :attributes)

        expect(response_body[:data][:id]).to be_a String
        expect(response_body[:data][:id].to_i).to eq last_subscription.id

        expect(response_body[:data][:type]).to be_a String
        expect(response_body[:data][:type]).to eq 'subscription'

        expect(response_body[:data][:attributes]).to be_a Hash
        expect(response_body[:data][:attributes].keys.count).to eq 5
        expect(response_body[:data][:attributes].keys).to include(:name, :status, :frequency, :customer, :teas)

        expect(response_body[:data][:attributes][:name]).to be_a String
        expect(response_body[:data][:attributes][:name]).to eq last_subscription.name

        expect(response_body[:data][:attributes][:status]).to be_a String
        expect(response_body[:data][:attributes][:status]).to eq last_subscription.status

        expect(response_body[:data][:attributes][:frequency]).to be_a String
        expect(response_body[:data][:attributes][:frequency]).to eq last_subscription.frequency

        expect(response_body[:data][:attributes][:customer]).to be_a Hash

        expect(response_body[:data][:attributes][:customer][:id]).to be_a Integer
      
        expect(response_body[:data][:attributes][:customer][:first_name]).to be_a String
        expect(response_body[:data][:attributes][:customer][:first_name]).to eq last_subscription.customer.first_name

        expect(response_body[:data][:attributes][:customer][:last_name]).to be_a String
        expect(response_body[:data][:attributes][:customer][:last_name]).to eq last_subscription.customer.last_name


        expect(response_body[:data][:attributes][:customer][:email]).to be_a String
        expect(response_body[:data][:attributes][:customer][:email]).to eq last_subscription.customer.email

        expect(response_body[:data][:attributes][:customer][:address]).to be_a String
        expect(response_body[:data][:attributes][:customer][:address]).to eq last_subscription.customer.address

        expect(response_body[:data][:attributes][:customer][:created_at]).to be_a String

        expect(response_body[:data][:attributes][:customer][:updated_at]).to be_a String
        
        response_body[:data][:attributes][:teas].each do |tea|
          expect(tea).to be_a Hash
          expect(tea.keys.count).to eq 8
          expect(tea.keys).to include(:id, :name, :description, :temperature_c, :brew_time_sec, :price, :created_at, :updated_at)

          test_tea = Tea.find(tea[:id])

          expect(tea[:id]).to be_a Integer
          expect(tea[:id].in?(Tea.ids)).to eq true

          expect(tea[:name]).to be_a String
          expect(tea[:name]).to eq test_tea.name

          expect(tea[:description]).to be_a String
          expect(tea[:description]).to eq test_tea.description

          expect(tea[:temperature_c]).to be_a Integer
          expect(tea[:temperature_c]).to eq test_tea.temperature_c

          expect(tea[:brew_time_sec]).to be_a Integer
          expect(tea[:brew_time_sec]).to eq test_tea.brew_time_sec

          expect(tea[:price]).to be_a Float
          expect(tea[:price]).to eq test_tea.price

          expect(tea[:created_at]).to be_a String

          expect(tea[:updated_at]).to be_a String
        end
      end
    end
    
    describe 'Sad Path' do
      it 'Returns an error if incorrect customer id' do
        create(:customer)
        create_list(:tea, 3)

        input_body = {
          'customer_id': 13251,
          'name': Faker::Subscription.plan,
          'frequency': Faker::Number.between(from: 0, to: 3),
          'teas': [ Tea.first.id, Tea.third.id ]
        }

        post api_v1_customer_subscriptions_path(input_body)

        expect(response).to_not be_successful
        expect(response.status).to eq 404

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to be_a Hash
        expect(response_body.keys.count).to eq 1
        expect(response_body.keys).to eq [ :description ]

        expect(response_body[:description]).to be_a String
        expect(response_body[:description]).to eq 'Error: Invalid parameters'
      end

      xit 'Returns an error if incorrect frequency' do
        create(:customer)
        create_list(:tea, 3)
        input_body = {
          'customer_id': Customer.first.id,
          'name': Faker::Subscription.plan,
          'frequency': 56,
          'teas': [ Tea.first.id, Tea.third.id ]
        }

        post api_v1_customer_subscriptions_path(input_body)

        expect(response).to_not be_successful
        expect(response.status).to eq 404

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to be_a Hash
        expect(response_body.keys.count).to eq 1
        expect(response_body.keys).to eq [ :description ]

        expect(response_body[:description]).to be_a String
        expect(response_body[:description]).to eq 'Error: Invalid parameters'
      end
      
      xit 'Returns an error if invalid tea' do
        create(:customer)
        create_list(:tea, 3)
        input_body = {
          'customer_id': Customer.first.id,
          'name': Faker::Subscription.plan,
          'frequency': Faker::Number.between(from: 0, to: 3),
          'teas': [ Tea.ids.first + 500 ]
        }

        binding.pry

        post api_v1_customer_subscriptions_path(input_body)

        expect(response).to_not be_successful
        expect(response.status).to eq 404

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body).to be_a Hash
        expect(response_body.keys.count).to eq 1
        expect(response_body.keys).to eq [ :description ]

        expect(response_body[:description]).to be_a String
        expect(response_body[:description]).to eq 'Error: Invalid parameters'
      end
    end
  end
  describe '#update -- cancel subscription' do
    describe 'Happy Path' do
      it "Can cancel a customer's subscription without deleting it" do
        create(:customer)
        create_list(:tea, 3)
        create(:subscription, customer_id: Customer.first.id, status: 1)
        3.times do
          create(:subscription_tea, subscription_id: Subscription.ids.sample, tea_id: Tea.ids.sample)
        end

        mock_customer = Customer.first.id
        mock_subscription = Subscription.first.id

        input_body = {
          'id': mock_subscription,
          'customer_id': mock_customer,
          'change': 'cancel'
        }

        patch api_v1_customer_subscription_path(input_body)

        expect(response).to be_successful
        expect(response.status).to eq 200

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body[:data][:attributes][:status]).to eq 'cancelled'
      end
    end

    describe 'Sad Path' do
      it "Returns an error if subscription doesn't exist" do
        create(:customer)
        create_list(:tea, 3)
        create(:subscription, customer_id: Customer.first.id, status: 0)
        3.times do
          create(:subscription_tea, subscription_id: Subscription.ids.sample, tea_id: Tea.ids.sample)
        end

        mock_customer = Customer.first.id
        mock_subscription = Subscription.first.id

        input_body = {
          'id': 50000,
          'customer_id': mock_customer,
          'change': 'cancel'
        }

        patch api_v1_customer_subscription_path(input_body)

        expect(response).to_not be_successful
        expect(response.status).to eq 404

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body[:description]).to eq 'Error: Invalid parameters'
      end

      xit "Returns an error if customer doesn't exist" do
        create(:customer)
        create_list(:tea, 3)
        create(:subscription, customer_id: Customer.first.id, status: 0)
        3.times do
          create(:subscription_tea, subscription_id: Subscription.ids.sample, tea_id: Tea.ids.sample)
        end

        mock_customer = Customer.first.id
        mock_subscription = Subscription.first.id

        input_body = {
          'id': mock_subscription,
          'customer_id': mock_customer+5000,
          'change': 'cancel'
        }

        patch api_v1_customer_subscription_path(input_body)

        expect(response).to_not be_successful
        expect(response.status).to eq 404

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body[:description]).to eq 'Error: Invalid parameters'
      end

      it "Returns an error if trying to update a subscription that is already cancelled" do
        create(:customer)
        create_list(:tea, 3)
        create(:subscription, customer_id: Customer.first.id, status: 0)
        3.times do
          create(:subscription_tea, subscription_id: Subscription.ids.sample, tea_id: Tea.ids.sample)
        end

        mock_customer = Customer.first.id
        mock_subscription = Subscription.first.id

        input_body = {
          'id': mock_subscription,
          'customer_id': mock_customer,
          'change': 'cancel'
        }

        patch api_v1_customer_subscription_path(input_body)

        expect(response).to_not be_successful
        expect(response.status).to eq 404

        response_body = JSON.parse(response.body, symbolize_names: true)

        expect(response_body[:description]).to eq 'Error: Subscription is already cancelled'
      end
    end
  end
end
