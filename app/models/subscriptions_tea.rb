class SubscriptionsTea < ApplicationRecord
    belongs_to :tea
    belongs_to :subscription

    validates :frequency, presence: true

    after_initialize :set_default_frequency, if: :new_record?

    private

    def set_default_frequency
        self.frequency ||= subscription.frequency if subscription
    end
end