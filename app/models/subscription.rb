class Subscription < ApplicationRecord
    has_many :customers_subscriptions
    has_many :customers, through: :customers_subscriptions
    has_many :subscriptions_teas
    has_many :teas, through: :subscriptions_teas

    validates :title, presence: true
    validates :price, numericality: true
    validates :frequency, presence: true
    validates :status, presence: true

    def cancel_subscriptions
        canceled_subs = self.customers_subscriptions.where("customers_subscriptions.status = ?", 'active').update_all(status: 'canceled')
    end

    def self.filter_by_price(search_params)
        return where("price < ?", search_params[:by_price]) if search_params[:by_price].present?
        return all
    end
end