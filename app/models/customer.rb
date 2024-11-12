class Customer < ApplicationRecord
    has_many :customers_subscriptions
    has_many :subscriptions, through: :customers_subscriptions

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, presence: true
    validates :address, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :zip_code, numericality: { only_integer: true }
end