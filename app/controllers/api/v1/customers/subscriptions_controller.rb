class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find_by(id: params[:customer_id])
    if customer.present?
      render json: CustomerSubscriptionsSerializer.new(Customer.find(params[:customer_id]))
    else
      render json: { description: "Error: No customer found with that ID" }, status: :not_found
    end
  end

  def create
    subscription = Subscription.new(
      customer_id: params[:customer_id],
      name: params[:name],
      frequency: params[:frequency].to_i
    )
    if subscription.save
      params[:teas].each do |tea_id|
        SubscriptionTea.create!(
          subscription_id: subscription.id,
          tea_id: tea_id.to_i
        )
      end
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { description: "Error: Invalid parameters"}, status: :not_found
    end
  end
end
