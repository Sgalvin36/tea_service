class Tea < ApplicationRecord
    has_many :subscriptions_teas
    has_many :subscriptions, through: :subscriptions_teas

    validates :title, presence: true
    validates :description, presence: true
    validates :temperature, numericality: { greater_than: 0 }
    validates :brew_time, numericality: { greater_than: 0 }
end