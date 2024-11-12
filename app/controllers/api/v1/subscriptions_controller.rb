class Api::V1::RecipesController < ApplicationController
    def index
    
    end

    def show

    end

    def update

    end

    private
    def user_params
        params.permit(:id, :by_location, :by_recipe, :by_ingredient, :by_style, :by_price, :by_serving)
    end
end