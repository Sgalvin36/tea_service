class Subscription < ApplicationRecord
    has_many :customers_subscriptions
    has_many :customers, through: :customers_subscriptions
    has_many :subscriptions_teas
    has_many :teas, through: :subscriptions_teas

    validates :title, presence: true
    validates :price, numericality: true
    validates :frequency, presence: true
    validates :status, presence: true
end