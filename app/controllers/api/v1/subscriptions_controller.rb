class Api::V1::SubscriptionsController < ApplicationController
    def index
        subscriptions = Subscription.all   
            # .filter_Subscriptions(user_params)
            # .filter_by_ingredient(user_params)
            # .filter_by_cooking_style(user_params)
            # .filter_by_price(user_params)
            # .filter_by_serving(user_params)

        render json: SubscriptionSerializer.new(subscriptions)
    end

    def show
        subscription = Subscription.find(user_params[:id])
        render json: SubscriptionSerializer.format_subscription_details(subscription)
    end

    def update

    end

    private
    def user_params
        params.permit(:id, :by_location, :by_recipe, :by_ingredient, :by_style, :by_price, :by_serving)
    end
end