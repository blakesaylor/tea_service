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
      render json: { description: "Error: Invalid parameters" }, status: :not_found
    end
  end

  def update
    subscription = Subscription.find_by_id(params[:id])
    if subscription.present?
      if params[:change] == 'cancel'
        cancel_subscription(subscription)
      # elsif restart_subscription
        # Some stuff to restart a subscription
      # elsif add_tea
        # Some stuff here to add a tea
      # elsif remove_tea
        # Some stuff here to remove a tea
      # elsif change_frequency
        # Some stuff here to change frequency
      end
    else
      render json: { description: "Error: Invalid parameters" }, status: :not_found
    end
  end

  private
  # def valid_update_param?
  #   ['cancel', 'restart_subscription', 'add_tea', 'remove_tea', 'change_frequency'].include?(params[:change])
  # end

  def cancel_subscription(subscription)
    if subscription.active?
      subscription.cancelled!
      render json: SubscriptionSerializer.new(subscription), status: :ok
    else
      render json: { description: "Error: Subscription is already cancelled" }, status: :not_found
    end
  end
end
