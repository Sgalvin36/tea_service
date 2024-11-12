require "rails_helper"

RSpec.describe Api::V1::SubscriptionsController, type: :request do
    before(:all) do
        SubscriptionsTea.delete_all
        CustomersSubscription.delete_all
        Customer.delete_all
        Subscription.delete_all
        Tea.delete_all

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
        
        @subscription1 = Subscription.create!(title:"Fresh n Fruity", price:12.99, frequency:"Monthly", status:"active")
        SubscriptionsTea.create!(subscription_id: @subscription1.id , tea_id: tea5.id)
        SubscriptionsTea.create!(subscription_id: @subscription1.id , tea_id: tea2.id)
        SubscriptionsTea.create!(subscription_id: @subscription1.id , tea_id: tea4.id)
        CustomersSubscription.create!(subscription_id: @subscription1.id, customer_id: customer4.id, status: "canceled")
        CustomersSubscription.create!(subscription_id: @subscription1.id, customer_id: customer2.id, status: "active")
        CustomersSubscription.create!(subscription_id: @subscription1.id, customer_id: customer3.id, status: "active")

        @subscription2 = Subscription.create!(title:"The Big Haul", price:36.99, frequency:"Quarterly", status:"active")
        SubscriptionsTea.create!(subscription_id: @subscription2.id , tea_id: tea1.id)
        SubscriptionsTea.create!(subscription_id: @subscription2.id , tea_id: tea2.id)
        SubscriptionsTea.create!(subscription_id: @subscription2.id , tea_id: tea3.id)
        SubscriptionsTea.create!(subscription_id: @subscription2.id , tea_id: tea6.id)
        CustomersSubscription.create!(subscription_id: @subscription2.id, customer_id: customer4.id, status: "active")
        CustomersSubscription.create!(subscription_id: @subscription2.id, customer_id: customer1.id, status: "active")

        @subscription3 = Subscription.create!(title:"Bold to Drink", price:4.99, frequency:"Bi-Weekly", status:"active")
        SubscriptionsTea.create!(subscription_id: @subscription3.id , tea_id: tea5.id)
        SubscriptionsTea.create!(subscription_id: @subscription3.id , tea_id: tea4.id)
        CustomersSubscription.create!(subscription_id: @subscription3.id, customer_id: customer4.id, status: "canceled")
        CustomersSubscription.create!(subscription_id: @subscription3.id, customer_id: customer3.id, status: "active")

        @subscription4 = Subscription.create!(title:"Classic Time", price:4.99, frequency:"Bi-Weekly", status:"canceled")
        SubscriptionsTea.create!(subscription_id: @subscription4.id , tea_id: tea1.id)
        CustomersSubscription.create!(subscription_id: @subscription4.id, customer_id: customer4.id, status: "canceled")
    end

    describe "GET all subscriptions Endpoint" do
        it "can make the request successfully" do
            headers = { 
                "CONTENT_TYPE" => "application/json",
            }

            get api_v1_subscriptions_path
            expect(response).to be_successful
            json = JSON.parse(response.body, symbolize_names: true)

            expect(json).to have_key(:data)
            json[:data].each do |subscription|
                expect(subscription[:type]).to eq("subscription")
                expect(subscription[:attributes]).to include(:title)
                expect(subscription[:attributes]).to include(:price)
                expect(subscription[:attributes]).to include(:frequency)
                expect(subscription[:attributes]).to include(:status)
            end
        end
    end

    describe "GET one subscription Endpoint" do
        it "can make the request successfully" do
            headers = { 
                "CONTENT_TYPE" => "application/json",
            }
            params = {
                id: @subscription1.id
            }
            get api_v1_subscription_path(params)
            expect(response).to be_successful
            json = JSON.parse(response.body, symbolize_names: true)

            expect(json).to have_key(:data)
            expect(json[:data][:id]).to eq(@subscription1.id)
            expect(json[:data][:type]).to eq("subscription")
            expect(json[:data][:attributes][:title]).to eq("Fresh n Fruity")
            expect(json[:data][:attributes][:price]).to eq(12.99)
            expect(json[:data][:attributes][:frequency]).to eq("Monthly")
            expect(json[:data][:attributes][:status]).to eq("active")
            expect(json[:data][:attributes][:active_customers].length).to eq 2
            expect(json[:data][:attributes][:inactive_customers].length).to eq 0
            expect(json[:data][:attributes][:teas].length).to eq 3
        end

        it "does not work without a valid id" do
            headers = { 
                "CONTENT_TYPE" => "application/json",
            }
            get api_v1_subscription_path(9999999999999999999999999)

            json = JSON.parse(response.body, symbolize_names: true)

            expect(response.status).to eq(404)

            expect(json).to have_key(:message)
            expect(json[:message]).to eq("Couldn't find Subscription with 'id'=9999999999999999999999999")
            expect(json).to have_key(:status)
            expect(json[:status]).to eq(404)
        end
    end
end