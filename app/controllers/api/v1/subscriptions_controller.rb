class Api::V1::SubscriptionsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    
    def index
        subscriptions = Subscription.all
            .filter_by_price(user_params)
        render json: SubscriptionSerializer.new(subscriptions)
    end

    def show
        subscription = Subscription.find(user_params[:id])
        render json: SubscriptionSerializer.format_subscription_details(subscription)
    end

    def update
        subscription = Subscription.find(user_params[:id])
        if user_params[:status].present?
            subscription.update!(status: user_params[:status])
            subscription.cancel_subscriptions if user_params[:status] == 'canceled'
        end
        render json: SubscriptionSerializer.format_subscription_details(subscription), status: :created
    end

    private
    def user_params
        params.permit(:id, :status, :by_price)
    end

    def record_not_found(exception)
        render json: ErrorSerializer.format_error(ErrorMessage.new(exception.message, 404)), status: :not_found
    end
end