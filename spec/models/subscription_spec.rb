require 'rails_helper'

RSpec.describe Subscription, type: :model do
    before(:all) do
        SubscriptionsTea.delete_all
        CustomersSubscription.delete_all
        Customer.delete_all
        Subscription.delete_all
        Tea.delete_all
    end

    describe "relationships" do
        it { should have_many :customers_subscriptions }
        it { should have_many(:customers).through(:customers_subscriptions) }
        it { should have_many :subscriptions_teas }
        it { should have_many(:teas).through(:subscriptions_teas) }
    end

    describe "validations" do
        it { should validate_presence_of(:title) }
        it { should validate_presence_of(:status) }
        it { should validate_presence_of(:frequency) }
        it { should validate_numericality_of(:price) }
    end

    describe "cancel_subcriptions" do
        it "updates the status of all customers for a specific subscription" do
            customer4 = Customer.create!(first_name: "Brandon", last_name: "Bradley", email: "BBLover@email.com", address: "231 Main St.", city: "Denver", state: "CO", zip_code:80502)
            subscription4 = Subscription.create!(title:"Classic Time", price:4.99, frequency:"Bi-Weekly", status:"active")
            CustomersSubscription.create!(subscription_id: subscription4.id, customer_id: customer4.id, status: "active")
        
            expect(subscription4.customers_subscriptions.first[:status]).to eq("active")
            subscription4.cancel_subscriptions
            expect(subscription4.customers_subscriptions.first[:status]).to_not eq("active")
            expect(subscription4.customers_subscriptions.first[:status]).to eq("canceled")
        end
    end

    describe "filters" do
        it "filters by price if search param is present" do
            subscription = Subscription.create!(title:"Classic Time", price:4.99, frequency:"Bi-Weekly", status:"active")
            subscription2 = Subscription.create!(title:"Classic Time2", price:7.99, frequency:"Bi-Weekly", status:"active")
            subscription3 = Subscription.create!(title:"Classic Time3", price:9.99, frequency:"Bi-Weekly", status:"active")
            results = Subscription.filter_by_price({by_price: 8})
            expect(results.length).to eq 2

            new_results = Subscription.filter_by_price({by_price: 10})
            expect(new_results.length).to eq 3
        end

        it "returns all if search param is not present" do
            subscription = Subscription.create!(title:"Classic Time", price:4.99, frequency:"Bi-Weekly", status:"active")
            subscription2 = Subscription.create!(title:"Classic Time2", price:7.99, frequency:"Bi-Weekly", status:"active")
            subscription3 = Subscription.create!(title:"Classic Time3", price:9.99, frequency:"Bi-Weekly", status:"active")
            search_params = {
                by_brew_time: 120
            }
            results = Subscription.filter_by_price(search_params)
            expect(results.length).to eq 3
        end
    end
end