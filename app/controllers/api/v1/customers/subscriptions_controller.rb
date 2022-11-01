class Api::V1::Customers::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find_by(id: params[:customer_id])
    if customer.present?
      render json: CustomerSubscriptionsSerializer.new(Customer.find(params[:customer_id]))
    else
      render json: { description: "Error: No customer found with that ID" }, status: :not_found
    end
  end
end
