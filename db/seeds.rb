# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
tea1 = Tea.create!(title: "Earl Gray", temperature: 135, brew_time: 180, description:"Lovely")
tea2 = Tea.create!(title: "Tempestuous Times", temperature: 120, brew_time: 210, description:"Light and fruity")
tea3 = Tea.create!(title: "Santa's Cocoa", temperature: 130, brew_time: 120, description:"Hints of cocoa")
tea4 = Tea.create!(title: "Elder Tea", temperature: 160, brew_time: 120, description:"Tastes of Elderberry")
tea5 = Tea.create!(title: "Herbal Tea", temperature: 150, brew_time: 180, description:"Strong citrus overtones")
tea6 = Tea.create!(title: "White Tea" , temperature: 145, brew_time: 210, description:"Delicate green tea")

customer1 = Customer.create!(first_name: "Steve", last_name: "Smith", email: "SSmith@email.com", address: "123 Main St.", city: "Denver", state: "CO", zip_code:80502)
customer2 = Customer.create!(first_name: "Sarah", last_name: "Smith", email: "SSmith2@email.com", address: "123 Main St.", city: "Denver", state: "CO", zip_code:80502)
customer3 = Customer.create!(first_name: "Bobby", last_name: "Filet", email: "SouffleFilet@email.com", address: "321 Main St.", city: "Denver", state: "CO", zip_code:80502)
customer4 = Customer.create!(first_name: "Brandon", last_name: "Bradley", email: "BBLover@email.com", address: "231 Main St.", city: "Denver", state: "CO", zip_code:80502)

subscription1 = Subscription.create!(title:"Fresh n Fruity", price:12.99, frequency:"Monthly", status:"active")
SubscriptionsTea.create!(subscription_id: subscription1.id , tea_id: tea5.id)
SubscriptionsTea.create!(subscription_id: subscription1.id , tea_id: tea2.id)
SubscriptionsTea.create!(subscription_id: subscription1.id , tea_id: tea4.id)
CustomersSubscription.create!(subscription_id: subscription1.id, customer_id: customer4.id, status: "canceled")
CustomersSubscription.create!(subscription_id: subscription1.id, customer_id: customer2.id, status: "active")
CustomersSubscription.create!(subscription_id: subscription1.id, customer_id: customer3.id, status: "active")

subscription2 = Subscription.create!(title:"The Big Haul", price:36.99, frequency:"Quarterly", status:"active")
SubscriptionsTea.create!(subscription_id: subscription2.id , tea_id: tea1.id)
SubscriptionsTea.create!(subscription_id: subscription2.id , tea_id: tea2.id)
SubscriptionsTea.create!(subscription_id: subscription2.id , tea_id: tea3.id)
SubscriptionsTea.create!(subscription_id: subscription2.id , tea_id: tea6.id)
CustomersSubscription.create!(subscription_id: subscription2.id, customer_id: customer4.id, status: "active")
CustomersSubscription.create!(subscription_id: subscription2.id, customer_id: customer1.id, status: "active")

subscription3 = Subscription.create!(title:"Bold to Drink", price:4.99, frequency:"Bi-Weekly", status:"active")
SubscriptionsTea.create!(subscription_id: subscription3.id , tea_id: tea5.id)
SubscriptionsTea.create!(subscription_id: subscription3.id , tea_id: tea4.id)
CustomersSubscription.create!(subscription_id: subscription3.id, customer_id: customer4.id, status: "canceled")
CustomersSubscription.create!(subscription_id: subscription3.id, customer_id: customer3.id, status: "active")

subscription4 = Subscription.create!(title:"Classic Time", price:4.99, frequency:"Bi-Weekly", status:"canceled")
SubscriptionsTea.create!(subscription_id: subscription4.id , tea_id: tea1.id)
CustomersSubscription.create!(subscription_id: subscription4.id, customer_id: customer4.id, status: "canceled")
