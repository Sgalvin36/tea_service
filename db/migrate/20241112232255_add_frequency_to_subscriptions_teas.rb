class AddFrequencyToSubscriptionsTeas < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions_teas, :frequency, :string
  end
end
