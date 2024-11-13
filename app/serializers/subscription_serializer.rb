class SubscriptionSerializer
    include JSONAPI::Serializer
    
    attributes :title, :price, :frequency, :status

    def self.format_subscription_details(sub_dets)
        {
            data: {
                id: sub_dets.id,
                type: "subscription",
                attributes: {
                    title: sub_dets.title,
                    price: sub_dets.price,
                    frequency: sub_dets.frequency,
                    status: sub_dets.status,
                    active_customers: format_customers(sub_dets, "active"),
                    inactive_customers: format_customers(sub_dets, "canceled") ,
                    teas: format_teas(sub_dets)
                }
            }
        }
    end

    private
    def self.format_customers(subscription, status)
        data = subscription.customers.where("customers_subscriptions.status = '#{status}'")
        if data.length > 0
            data.map do |customer| 
                {
                    first_name: customer.first_name,
                    last_name: customer.last_name,
                    address: customer.address,
                    city_state: "#{customer.city}, #{customer.state}",
                    zip_code: customer.zip_code,
                    email: customer.email,
                    status: status
                }
            end
        end
        data
    end

    def self.format_teas(subscription)
        data = subscription.teas
        if data.length > 0
            data.map do |tea| 
                {
                    title: tea.title,
                    temperature: tea.temperature,
                    brew_time: tea.brew_time
                }
            end
        end
        data
    end
end