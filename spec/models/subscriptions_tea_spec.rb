require 'rails_helper'

RSpec.describe SubscriptionsTea, type: :model do
    describe "relationships" do
        it { should belong_to :tea }
        it { should belong_to :subscription }
    end

    describe "validations" do
        it { should validate_presence_of(:frequency) }
    end

    describe "#set_default_frequency" do
        it "sets the default to match the subscription frequency" do
            sub = Subscription.create!(title:"Classic Time", price:4.99, frequency:"Bi-Weekly", status:"active")
            tea1 = Tea.create!(title: "Earl Gray", temperature: 135, brew_time: 180, description:"Lovely")
            data = SubscriptionsTea.create!(subscription_id: sub.id, tea_id: tea1.id)
            
            expect(data.frequency).to eq(sub.frequency)
        end

        it "can set the frequency for each tea individually" do
            sub = Subscription.create!(title:"Classic Time", price:4.99, frequency:"Bi-Weekly", status:"active")
            tea1 = Tea.create!(title: "Earl Gray", temperature: 135, brew_time: 180, description:"Lovely")
            data = SubscriptionsTea.create!(subscription_id: sub.id, tea_id: tea1.id, frequency:"Monthly")
            
            expect(data.frequency).to_not eq(sub.frequency)
            expect(data.frequency).to eq("Monthly")

        end
    end
end