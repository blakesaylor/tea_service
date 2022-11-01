# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
blake = Customer.create!( first_name: 'blake',
                      last_name: 'saylor',
                      email: 'blakesaylor@gmail.com',
                      address: '123 Fake Street')
mike = Customer.create!(first_name: 'mike',
                    last_name: 'koulouvaris',
                    email: 'mikekoul@gmail.com',
                    address: '456 Super Fake Street')
thomas = Customer.create!(first_name: 'thomas',
                      last_name: 'turner',
                      email: 'thomasturner@gmail.com',
                      address: '789 Most Fake Street')

green_tea = Tea.create!(name: 'green tea',
                    description: 'a tea that is green',
                    temperature_c: 160,
                    brew_time_sec: 120,
                    price: 4.99)
black_tea = Tea.create!(name: 'black tea',
                    description: 'a tea that is black',
                    temperature_c: 180,
                    brew_time_sec: 150,
                    price: 3.99)
grey_tea = Tea.create!(name: 'grey tea',
                    description: 'a tea that is grey',
                    temperature_c: 140,
                    brew_time_sec: 60,
                    price: 6.50)

# Create 2 subscriptions for Blake
blake_subscription_1 = Subscription.create!(
  name: "Blake's first subscription",
  status: 0,
  frequency: 1,
  customer_id: blake.id
)

blake_subscription_2 = Subscription.create!(
  name: "Blake's second subscription",
  status: 1,
  frequency: 3,
  customer_id: blake.id
)

# Create 1 subscription for Mike
mike_subscription_1 = Subscription.create!(
  name: "Mike's first subscription",
  status: 1,
  frequency: 1,
  customer_id: mike.id
)

# Create 3 subscriptions for Thomas
thomas_subscription_1 = Subscription.create!(
  name: "Thomas's first subscription",
  status: 1,
  frequency: 0,
  customer_id: thomas.id
)
thomas_subscription_2 = Subscription.create!(
  name: "Thomas's second subscription",
  status: 1,
  frequency: 1,
  customer_id: thomas.id
)
thomas_subscription_3 = Subscription.create!(
  name: "Thomas's third subscription",
  status: 1,
  frequency: 2,
  customer_id: thomas.id
)

# Create 2 teas in Blake's first subscription
blake_subsciption_tea_1 = SubscriptionTea.create!(
  subscription_id: blake_subscription_1.id,
  tea_id: green_tea.id
)
blake_subsciption_tea_2 = SubscriptionTea.create!(
  subscription_id: blake_subscription_1.id,
  tea_id: black_tea.id
)

# Create 1 tea in Blake's second subscription
blake_subsciption_tea_3 = SubscriptionTea.create!(
  subscription_id: blake_subscription_2.id,
  tea_id: grey_tea.id
)

# Create 3 teas in Mike's first subscription
mike_subscription_tea_1 = SubscriptionTea.create!(
  subscription_id: mike_subscription_1.id,
  tea_id: green_tea.id
)
mike_subscription_tea_2 = SubscriptionTea.create!(
  subscription_id: mike_subscription_1.id,
  tea_id: black_tea.id
)
mike_subscription_tea_3 = SubscriptionTea.create!(
  subscription_id: mike_subscription_1.id,
  tea_id: grey_tea.id
)

# Create 1 tea in Thomas's first subscription
thomas_subsciption_tea_1 = SubscriptionTea.create!(
  subscription_id: thomas_subscription_1.id,
  tea_id: green_tea.id
)

# Create 1 tea in Thomas's second subscription
thomas_subsciption_tea_2 = SubscriptionTea.create!(
  subscription_id: thomas_subscription_2.id,
  tea_id: grey_tea.id
)

# Create 1 tea in Thomas's third subscription
thomas_subsciption_tea_3 = SubscriptionTea.create!(
  subscription_id: thomas_subscription_3.id,
  tea_id: black_tea.id
)

