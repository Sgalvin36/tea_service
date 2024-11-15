require 'rails_helper'

RSpec.describe CustomersSubscription, type: :model do
    describe "relationships" do
        it { should belong_to :customer }
        it { should belong_to :subscription }
    end

    describe "validations" do
        it { should validate_presence_of(:status) }
    end
end