require 'rails_helper'

RSpec.describe Customer, type: :model do
    describe "relationships" do
        it { should have_many :customers_subscriptions }
        it { should have_many(:subscriptions).through(:customers_subscriptions) }
    end

    describe "validations" do
        it { should validate_presence_of(:first_name) }
        it { should validate_presence_of(:last_name) }
        it { should validate_presence_of(:email) }
        it { should validate_presence_of(:address) }
        it { should validate_presence_of(:city) }
        it { should validate_presence_of(:state) }
        it { should validate_numericality_of(:zip_code) }
    end
end