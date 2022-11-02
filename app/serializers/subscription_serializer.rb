class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :name, :status, :frequency, :customer, :teas

  
end
